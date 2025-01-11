require("lib.choose_utils")

-- 注册choose回调
bindHttpCallback("choose", function(payload)
    print("收到choose请求:", hs.json.encode(payload))

    -- 参数校验
    if not payload then
        print("❌ choose请求失败: payload为空")
        error("payload不能为空")
    end

    if not payload.choices then
        print("❌ choose请求失败: choices为空")
        error("choices不能为空") 
    end

    if #payload.choices == 0 then
        print("❌ choose请求失败: choices数组为空")
        error("choices数组不能为空")
    end

    -- 创建一个promise来等待choose结果
    local promise = {}
    promise.done = false
    promise.result = nil

    print("✅ choose请求开始")
    -- 调用choose并保存结果
    custom_choose(
        payload.placeholder,
        payload.choices,
        function(choice)
            promise.done = true
            promise.result = choice
            print("用户选择了:", hs.json.encode(choice))
        end
    )

    -- 等待choose完成
    while not promise.done do
        hs.timer.usleep(1000)
    end

    -- 返回选择结果
    print("✅ choose请求完成")
    return {
        choice = promise.result
    }
end)

--[[ 使用示例:
curl -X POST http://localhost:8000/invoke \
-H "Content-Type: application/json" \
-d '{
    "action": "choose",
    "payload": {
        "placeholder": "请选择一个选项",
        "choices": [
            {
                "text": "选项1",
                "subText": "描述1" 
            },
            {
                "text": "选项2",
                "subText": "描述2"
            }
        ]
    }
}'
]]--