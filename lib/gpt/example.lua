local chatGPTAPI = require(game.ReplicatedStorage.chatGPTAPI)
local chatGPT = chatGPTAPI.new("This is where you insert your personal API key from OpenAI.")

do
    chatGPT:sendMessage("Hi! Are you chatGPT?")

    local chatGPTRequest = chatGPT:sendMessage("What was my first question?")
    print(chatGPTRequest.success and chatGPTRequest.response) -- Your first question was, "Hi! Are you chatGPT?"

    chatGPT:resetChatHistory()
    local chatGPTRequest = chatGPT:sendMessage("What was my first question?")
    print(chatGPTRequest.success and chatGPTRequest.response) -- Unfortunately, I don't have access to the history of your previous questions. Please reword your question more specifically.
end