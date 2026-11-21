-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function toError(arg1)
    if typeof(arg1) ~= "table" or typeof(arg1.message) ~= "string" then
        return {
            message = debug.traceback(tostring(arg1))
        }
    end

    local result = ({})
    for value, value2 in arg1 do
        if typeof(value) == "string" then
            result[value] = value2
        end
    end
    return result
end

local function createShell(tbl1)
    local reconnectInterval = tbl1.reconnectInterval or 2
    local webSocketService = tbl1.webSocketService
    local tbl2 = ({})

    local tbl3 = ({})
    local tbl4 = {}
    local var1 = nil
    local bool1 = false
    local bool2 = false

    local module = ({})

    local function methodNames() -- Luacid: Inlined by compiler; 1 call site recovered
        local result = {}
        for value in tbl2 do
            table.insert(result, value)
        end
        table.sort(result)
        return result
    end

    function module.hello()
        return {
            contexts = table.clone(tbl4),
            methods = methodNames()
        }
    end
    local function sendHello() -- Luacid: Inlined by compiler; 4 call sites recovered
        local var2 = var1
        if var2 == nil then
            return
        end
        pcall(function()
            var2:Send(HttpService:JSONEncode({ jsonrpc = "2.0", method = "shell.hello", params = module.hello() }))
        end)
    end

    tbl2["shell.methods"] = function()
        return module.hello()
    end

    function module.registerMethods(str1: string, tbl5)
        if str1 == "" or string.find(str1, ".", 1, true) then
            error(`DevShell: namespace "{str1}" must be non-empty and contain no "."`, 2)
        end
        if str1 == "shell" then
            error("DevShell: namespace \"shell\" is reserved", 2)
        end
        local var2 = tbl3[str1] and tbl3[str1][tbl5]
        if var2 then
            return var2
        end
        local tbl6 = ({})
        for value, value2 in tbl5 do
            local str2 = `{str1}.{value}`
            if tbl2[str2] ~= nil then
                error(`DevShell: method "{str2}" is already registered`, 2)
            end
            tbl6[str2] = value2
        end
        for value, value2 in tbl6 do
            tbl2[value] = value2
        end

        sendHello()

        local function unregister()
            for value, value2 in tbl6 do
                if tbl2[value] == value2 then
                    tbl2[value] = nil
                end
            end
            tbl6 = {}
            local var3 = tbl3[str1]
            if var3 and var3[tbl5] == unregister then
                var3[tbl5] = nil
            end

            sendHello()
        end

        tbl3[str1] = tbl3[str1] or {}
        tbl3[str1][tbl5] = unregister
        return unregister
    end

    function module.handleRequest(arg1)
        local bool3 = typeof(arg1) == "table"
        local tbl5 = {
            id = if bool3 then arg1.id else nil,
            jsonrpc = if bool3 then arg1.jsonrpc else nil,
            result = nil,
            error = nil
        }

        if not bool3 or typeof(arg1.method) ~= "string" then
            tbl5.error = { message = "Invalid JSON-RPC request" }
            return tbl5
        end

        local var2 = tbl2[arg1.method]
        if var2 == nil and not string.find(arg1.method, ".", 1, true) then
            var2 = tbl2[`memory.{arg1.method}`]
        end
        if var2 == nil then
            tbl5.error = {
                message = string.format("Unknown method \"%s\"", arg1.method)
            }
            return tbl5
        end

        local success, result = xpcall(function()
            return var2(arg1.params)
        end, toError)
        if success then
            tbl5.result = result
        else
            tbl5.error = result
        end
        return tbl5
    end

    function module.isConnected(): boolean
        return var1 ~= nil
    end

    local connectWithRetry = nil

    local function tryConnect(): boolean
        if var1 ~= nil then
            return true
        end

        local var2 = webSocketService
        if var2 == nil then
            return false
        end
        local success, result = pcall(function()
            return var2:CreateClient(tbl1.host)
        end)
        if not (success and result) then
            return false
        end
        var1 = result

        result.Closed:Connect(function()
            if var1 ~= result then
                return
            end
            var1 = nil
            if not bool1 then
                return
            end

            task.delay(reconnectInterval, connectWithRetry)
        end)

        result.MessageReceived:Connect(function(input: string)
            pcall(function()
                local var3 = HttpService:JSONDecode(input)
                if typeof(var3) == "table" and var3.id == nil then
                    return
                end
                result:Send(HttpService:JSONEncode(module.handleRequest(var3)))
            end)
        end)

        sendHello()
        return true
    end

    connectWithRetry = function()
        if bool2 or not bool1 then
            return
        end
        bool2 = true
        task.spawn(function()
            while bool1 and var1 == nil and not tryConnect() do
                task.wait(reconnectInterval)
            end
            bool2 = false
        end)
    end

    function module.start(tbl5)
        if not table.find(tbl4, tbl5.context) then
            table.insert(tbl4, tbl5.context)
            sendHello()
        end

        if bool1 or not tbl1.enabled then
            return
        end
        if webSocketService == nil then
            local success, result = pcall(function(): WebSocketService
                return game:GetService("WebSocketService")
            end)
            if not success or result == nil then
                return
            end
            webSocketService = result
        end
        bool1 = true
        connectWithRetry()
    end

    function module.stop()
        bool1 = false
        local var2 = var1
        var1 = nil
        if var2 then
            pcall(function()
                var2:Close()
            end)
        end
    end

    return module
end

return createShell
