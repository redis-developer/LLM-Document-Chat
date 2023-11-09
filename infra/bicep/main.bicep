@description('That name is the name of our application. It has to be unique.Type a name followed by your resource group name. (<name>-<resourceGroupName>)')
param cognitiveServiceName string = 'CognitiveService'

@description('Location for all resources.')
param location string = resourceGroup().location
param OpenAIQuota int = 100

module openAi 'openai.bicep' = {
  name: 'openai'
  params: {
    name: cognitiveServiceName
    location: location
    sku: {
      name: 'S0'

    }
    deployments: [
      {
        name: 'EmbeddingAdaModel'
        model: {
          format: 'OpenAI'
          name: 'text-embedding-ada-002'
          version: '2'
        }
        capacity: OpenAIQuota
      }
      {
        name: 'GPT35Model'
        model: {
          format: 'OpenAI'
          name: 'gpt-35-turbo-instruct'
        }
        sku: {
          name: 'Standard'
          capacity: OpenAIQuota
        }
      }
    ]
  }
}

param redisEnterpriseName string = 'RedisEnterpriseLLMDocChat'
resource RedisEnterprise 'Microsoft.Cache/redisEnterprise@2022-01-01' = {
  name: redisEnterpriseName
  location: location
  sku: {
    capacity: 2
    name: 'Enterprise_E5'
  }
  properties: {
    minimumTlsVersion: '1.2'
  }
}

resource RedisEnterpriseDB 'Microsoft.Cache/redisEnterprise/databases@2022-01-01' = {
  name: 'default'
  parent: RedisEnterprise
  properties: {
    clientProtocol: 'PlainText'
    clusteringPolicy: 'EnterpriseCluster'
    evictionPolicy: 'NoEviction'
    modules: [
      {
        name: 'RediSearch'
      }
    ]
  }
}

output REDIS_ADDRESS string = RedisEnterprise.properties.hostName
