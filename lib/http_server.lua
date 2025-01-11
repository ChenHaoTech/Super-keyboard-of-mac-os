--[[ 
ref:
https://www.hammerspoon.org/docs/hs.httpserver.html
hs.httpserver
Simple HTTP server

Notes:

Running an HTTP server is potentially dangerous, you should seriously consider the security implications of exposing your Hammerspoon instance to a network - especially to the Internet
As a user of Hammerspoon, you are assumed to be highly capable, and aware of the security issues
Submodules
hs.httpserver.hsminweb
API Overview
Functions - API calls offered directly by the extension
new
Methods - API calls which can only be made on an object returned by a constructor
getInterface
getName
getPort
maxBodySize
send
setCallback
setInterface
setName
setPassword
setPort
start
stop
websocket
API Documentation
Functions
new
Signature	hs.httpserver.new([ssl], [bonjour]) -> object
Type	Function
Description	
Creates a new HTTP or HTTPS server

Parameters	
ssl - An optional boolean. If true, the server will start using HTTPS. Defaults to false.
bonjour - An optional boolean. If true, the server will advertise itself with Bonjour. Defaults to true. Note that in order to change this, you must supply a true or false value for the ssl argument.
Returns	
An hs.httpserver object
Notes	
By default, the server will start on a random TCP port and advertise itself with Bonjour. You can check the port with hs.httpserver:getPort()
By default, the server will listen on all network interfaces. You can override this with hs.httpserver:setInterface() before starting the server
Currently, in HTTPS mode, the server will use a self-signed certificate, which most browsers will warn about. If you want/need to be able to use hs.httpserver with a certificate signed by a trusted Certificate Authority, please file an bug on Hammerspoon requesting support for this.
Source	extensions/httpserver/libhttpserver.m line 374
Methods
getInterface
Signature	hs.httpserver:getInterface() -> string or nil
Type	Method
Description	
Gets the network interface the server is configured to listen on

Parameters	
None
Returns	
A string containing the network interface name, or nil if the server will listen on all interfaces
Source	extensions/httpserver/libhttpserver.m line 647
getName
Signature	hs.httpserver:getName() -> string
Type	Method
Description	
Gets the Bonjour name the server is configured to advertise itself as

Parameters	
None
Returns	
A string containing the Bonjour name of this server
Notes	
This is not the hostname of the server, just its name in Bonjour service lists (e.g. Safari's Bonjour bookmarks menu)
Source	extensions/httpserver/libhttpserver.m line 689
getPort
Signature	hs.httpserver:getPort() -> number
Type	Method
Description	
Gets the TCP port the server is configured to listen on

Parameters	
None
Returns	
A number containing the TCP port
Source	extensions/httpserver/libhttpserver.m line 616
maxBodySize
Signature	hs.httpserver:maxBodySize([size]) -> object | current-value
Type	Method
Description	
Get or set the maximum allowed body size for an incoming HTTP request.

Parameters	
size - An optional integer value specifying the maximum body size allowed for an incoming HTTP request in bytes. Defaults to 10485760 (10 MB).
Returns	
If a new size is specified, returns the hs.httpserver object; otherwise the current value.
Notes	
Because the Hammerspoon http server processes incoming requests completely in memory, this method puts a limit on the maximum size for a POST or PUT request.
Source	extensions/httpserver/libhttpserver.m line 513
send
Signature	hs.httpserver:send(message) -> object
Type	Method
Description	
Sends a message to the websocket client

Parameters	
message - A string containing the message to send
Returns	
The hs.httpserver object
Source	extensions/httpserver/libhttpserver.m line 446
setCallback
Signature	hs.httpserver:setCallback([callback]) -> object
Type	Method
Description	
Sets the request handling callback for an HTTP server object

Parameters	
callback - An optional function that will be called to process each incoming HTTP request, or nil to remove an existing callback. See the notes section below for more information about this callback
Returns	
The hs.httpserver object
Notes	
The callback will be passed four arguments:

A string containing the type of request (i.e. GET/POST/DELETE/etc)

A string containing the path element of the request (e.g. /index.html)

A table containing the request headers

A string containing the raw contents of the request body, or the empty string if no body is included in the request.

The callback must return three values:

A string containing the body of the response

An integer containing the response code (e.g. 200 for a successful request)

A table containing additional HTTP headers to set (or an empty table, {}, if no extra headers are required)

A POST request, often used by HTML forms, will store the contents of the form in the body of the request.

Source	extensions/httpserver/libhttpserver.m line 466
setInterface
Signature	hs.httpserver:setInterface(interface) -> object
Type	Method
Description	
Sets the network interface the server is configured to listen on

Parameters	
interface - A string containing an interface name
Returns	
The hs.httpserver object
Notes	
As well as real interface names (e.g. en0) the following values are valid:
An IP address of one of your interfaces
localhost
loopback
nil (which means all interfaces, and is the default)
Source	extensions/httpserver/libhttpserver.m line 662
setName
Signature	hs.httpserver:setName(name) -> object
Type	Method
Description	
Sets the Bonjour name the server should advertise itself as

Parameters	
name - A string containing the Bonjour name for the server
Returns	
The hs.httpserver object
Notes	
This is not the hostname of the server, just its name in Bonjour service lists (e.g. Safari's Bonjour bookmarks menu)
Source	extensions/httpserver/libhttpserver.m line 707
setPassword
Signature	hs.httpserver:setPassword([password]) -> object
Type	Method
Description	
Sets a password for an HTTP server object

Parameters	
password - An optional string that contains the server password, or nil to remove an existing password
Returns	
The hs.httpserver object
Notes	
It is not currently possible to set multiple passwords for different users, or passwords only on specific paths
Source	extensions/httpserver/libhttpserver.m line 539
setPort
Signature	hs.httpserver:setPort(port) -> object
Type	Method
Description	
Sets the TCP port the server is configured to listen on

Parameters	
port - An integer containing a TCP port to listen on
Returns	
The hs.httpserver object
Source	extensions/httpserver/libhttpserver.m line 631
start
Signature	hs.httpserver:start() -> object
Type	Method
Description	
Starts an HTTP server object

Parameters	
None
Returns	
The hs.httpserver object
Source	extensions/httpserver/libhttpserver.m line 573
stop
Signature	hs.httpserver:stop() -> object
Type	Method
Description	
Stops an HTTP server object

Parameters	
None
Returns	
The hs.httpserver object
Source	extensions/httpserver/libhttpserver.m line 599
websocket
Signature	hs.httpserver:websocket(path, callback) -> object
Type	Method
Description	
Enables a websocket endpoint on the HTTP server

Parameters	
path - A string containing the websocket path such as '/ws'
callback - A function returning a string for each received websocket message
Returns	
The hs.httpserver object
Notes	
The callback is passed one string parameter containing the received message
The callback must return a string containing the response message
Given a path '/mysock' and a port of 8000, the websocket URL is as follows:
ws://localhost:8000/mysock
wss://localhost:8000/mysock (if SSL enabled)
Source	extensions/httpserver/libhttpserver.m line 415
]]

-- 创建一个新的 HTTP 服务器实例
local server = hs.httpserver.new(false, true)

-- 设置端口为 8000
server:setPort(8000)

-- 存储所有连接的 websocket 客户端
local clients = {}

-- 处理 websocket 连接
server:websocket("/hello", function(message)
    -- 解析传入的消息,获取参数
    local param = message:match("param=([^&]+)")
    if param then
        -- 返回 world + 参数值
        return "world " .. param
    end
    return "world"
end)

-- 启动服务器
server:start()

-- 提供主动下发消息的函数
function broadcast_message(msg)
    -- 遍历所有连接的客户端发送消息
    for _, client in ipairs(clients) do
        client:send(msg)
    end
end

-- 使用示例:
-- broadcast_message("hello from server")

-- 测试方法:
-- 1. 使用 wscat 等工具连接 ws://localhost:8000/hello
-- 2. 发送消息: param=test
-- 3. 将收到响应: world test


-- 存储 action 对应的回调函数
local _callbacks = {}

-- 绑定 action 回调函数
function bindHttpCallback(action, callback)
    _callbacks[action] = callback
    print("bindHttpCallback", action)
end


-- 提供停止服务器的函数
function stop_http_server()
    server:stop()
    print("❌http server stopped")
end



stop_http_server()
-- 处理 HTTP 请求
server:setCallback(function(method, path, headers, body)
    -- 检查路径是否为 /invoke
    if path:match("^/invoke") then
        -- 检查请求方法
        if method ~= "GET" and method ~= "POST" then
            return hs.json.encode({
                code = 405,
                message = string.format("Method %s not allowed", method)
            }), 405, {
                ["Content-Type"] = "application/json",
                ["Access-Control-Allow-Origin"] = "*"
            }
        end

        -- 如果body为空,返回错误
        if not body or body == "" then
            return hs.json.encode({
                code = 400,
                message = "Empty request body",
                data = {
                    headers = headers
                }
            }), 400, {
                ["Content-Type"] = "application/json", 
                ["Access-Control-Allow-Origin"] = "*"
            }
        end

        -- 解析 JSON 数据
        local success, request = pcall(hs.json.decode, body)
        if not success then
            return hs.json.encode({
                code = 400,
                message = "Invalid JSON format",
                data = {
                    body = body,
                    headers = headers
                }
            }), 400, {
                ["Content-Type"] = "application/json",
                ["Access-Control-Allow-Origin"] = "*"
            }
        end

        -- 检查必需字段
        if not request.action then
            return hs.json.encode({
                code = 400,
                message = "Missing required field 'action'",
                data = {
                    request = request
                }
            }), 400, {
                ["Content-Type"] = "application/json",
                ["Access-Control-Allow-Origin"] = "*"
            }
        end

        -- 查找并执行对应的回调函数
        local callback = _callbacks[request.action]
        if callback then
            -- 执行回调函数
            local success, result = pcall(callback, request.payload)
            if success then
                return hs.json.encode({
                    code = 200,
                    message = "Success",
                    data = result
                }), 200, {
                    ["Content-Type"] = "application/json",
                    ["Access-Control-Allow-Origin"] = "*"
                }
            else
                return hs.json.encode({
                    code = 500,
                    message = "回调函数执行失败",
                    data = {
                        error = result
                    }
                }), 500, {
                    ["Content-Type"] = "application/json",
                    ["Access-Control-Allow-Origin"] = "*"
                }
            end
        end

        return hs.json.encode({
            code = 404,
            message = "未找到对应的处理函数",
            data = {
                action = request.action
            }
        }), 404, {
            ["Content-Type"] = "application/json",
            ["Access-Control-Allow-Origin"] = "*"
        }
    end
    
    -- 其他路径返回 404
    return hs.json.encode({
        code = 404,
        message = "接口不存在"
    }), 404, {
        ["Content-Type"] = "application/json"
    }
end)

-- 默认启动服务器
server:start()

print("✅http server started")



require("lib.http_server.choose")
require("lib.http_server.toast")