-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function observeAdminStatus(arg1, arg2, callback)
    local num1 = 0
    local connection = nil
    local var1 = nil
    local var2 = nil
    local var3 = nil
    local var4 = nil

    local function disconnectUserIdConnection() -- Luacid: Inlined by compiler; 3 call sites recovered
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end

    local function refresh() -- Luacid: Inlined by compiler; 1 call site recovered
        num1 += 1
        var4 = nil
        var1 = nil
        var2 = nil
        var3 = nil
        disconnectUserIdConnection()
        local localPlayer = arg1.LocalPlayer
        if localPlayer then
            connection = localPlayer:GetPropertyChangedSignal("UserId"):Connect(refresh)
        end
        callback()
    end

    local function authorize()
        local localPlayer = arg1.LocalPlayer
        if not localPlayer or localPlayer.UserId <= 0 then
            return false
        end
        local userId = localPlayer.UserId
        if var1 == localPlayer and var2 == userId and var3 ~= nil then
            return var3
        end
        if var4 == num1 then
            return false
        end

        local num2 = num1
        var4 = num2
        local success, result = pcall(function()
            return arg2(userId)
        end)
        if var4 == num2 then
            var4 = nil
        end

        if num2 ~= num1 or arg1.LocalPlayer ~= localPlayer or localPlayer.UserId ~= userId then
            return false
        end
        if not success then
            return false
        end

        var1 = localPlayer
        var2 = userId
        var3 = result == true
        return var3
    end

    local connection2 = arg1:GetPropertyChangedSignal("LocalPlayer"):Connect(refresh)
    refresh()

    local function disconnect()
        num1 += 1
        disconnectUserIdConnection()
        connection2:Disconnect()
    end

    return authorize, disconnect
end

return observeAdminStatus
