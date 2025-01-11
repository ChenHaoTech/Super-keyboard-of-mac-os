-- 注册示例回调
bindHttpCallback("toast", function(payload)
    if not payload or not payload.message then
        error("缺少必要的消息内容")
    end
    hs.alert.show(payload.message)
    return {
        toast = "displayed"
    }
end)

--[[ 

curl -X POST \
  http://localhost:8000/invoke \
  -H 'Content-Type: application/json' \
  -d '{
    "action": "toast",
    "payload": {
        "message": "测试消息"
    }
}'
]]