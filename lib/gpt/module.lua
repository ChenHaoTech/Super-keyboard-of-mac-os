local chatGPTAPI = {}
chatGPTAPI.__index = chatGPTAPI
local httpService = game:GetService("HttpService")

function chatGPTAPI.new(openAIKey)
    local selfInfo = {}
    selfInfo.openAIKey = openAIKey
    selfInfo.chatHistory = {}

    return setmetatable(selfInfo, chatGPTAPI)
end

function chatGPTAPI:sendMessage(inputText)
    table.insert(self.chatHistory, {role = "user", content = inputText})

    local httpResponse = httpService:RequestAsync({
        Url = "https://api.openai.com/v1/chat/completions",
        Method = "POST",
        Body = httpService:JSONEncode({
            model = "gpt-3.5-turbo",
            messages = self.chatHistory
            -- [API Reference - OpenAI API](https://platform.openai.com/docs/api-reference/chat/create)
            --[[ 这里可以补上 stream 参数 ]]
        }),
        Headers = {
            ["Content-Type"] = "application/json",
            Authorization = string.format("Bearer %s", self.openAIKey)
        }
    })
    local requestResponse = false
    if httpResponse.Success then
        local decodedRequestData = httpService:JSONDecode(httpResponse.Body)
        local messageData = decodedRequestData.choices[1].message
        table.insert(self.chatHistory, messageData)

        requestResponse = string.gsub(messageData.content, "^[%s\n]*", "")
    end

    return {success = httpResponse.Success, response = requestResponse}
end

function chatGPTAPI:resetChatHistory() self.chatHistory = {} end

return chatGPTAPI
