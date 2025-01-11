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

    -- 创建协程
    local co
    local result
    co = coroutine.create(function()
        print("✅ choose请求开始")
        
        custom_choose(
            payload.placeholder,
            payload.choices,
            function(choice)
                result = choice
                print("用户选择了:", hs.json.encode(choice))
                coroutine.resume(co, result)
            end
        )
        
        -- 暂停协程，等待选择完成
        result = coroutine.yield()
        
        -- print("✅ choose请求完成")
        -- return {
        --     choice = result
        -- }
    end)
    -- 启动协程
    local success, result = coroutine.resume(co)
    if not success then
        error("协程执行失败: " .. tostring(result))
    else
        print("✅ choose请求完成, result:" .. tostring(result))
    end
    
    return result
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