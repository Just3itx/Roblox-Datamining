-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Players = game:GetService("Players")

local Cryo = require(DataHydrationParent.Cryo)

local function getLocalPlayerUserId(): number? -- Luacid: Inlined by compiler; 1 call site recovered
    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId or nil

    return if userId == nil or userId <= 0 then nil else userId
end

return {
    areAllKeysPresent = function(arg1, tbl1)
        if arg1 == nil or type(arg1) ~= "table" then
            return #tbl1 == 0
        end
        for _, value in tbl1 do
            if arg1[value] == nil then
                return false
            end
        end
        return true
    end,
    getLocalPlayerUserId = getLocalPlayerUserId,
    observeLocalPlayerUserId = function(callback: (...any) -> (...any))
        local userId = if Players.LocalPlayer then Players.LocalPlayer.UserId or nil else nil
        local var1 = if userId == nil or userId <= 0 then nil else userId
        local connection = nil

        local bool1 = false

        local function notifyIfChanged() -- Luacid: Inlined by compiler; 1 call site recovered
            local userId2 = Players.LocalPlayer and Players.LocalPlayer.UserId or nil

            if userId2 == nil or userId2 <= 0 then
                userId2 = nil
            end

            if userId2 == var1 then
                return
            end
            var1 = userId2
            callback(userId2)
        end

        local function bindLocalPlayer() -- Luacid: Inlined by compiler; 2 call sites recovered
            if connection ~= nil then
                connection:Disconnect()
                connection = nil
            end

            local localPlayer = Players.LocalPlayer
            if localPlayer ~= nil then
                connection = localPlayer:GetPropertyChangedSignal("UserId"):Connect(notifyIfChanged)
            end
        end

        bindLocalPlayer()

        local connection2 = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
            bindLocalPlayer()
            notifyIfChanged()
        end)

        return function()
            if bool1 then
                return
            end
            bool1 = true

            if connection ~= nil then
                connection:Disconnect()
                connection = nil
            end
            if connection2 ~= nil then
                connection2:Disconnect()
                connection2 = nil
            end
        end
    end,
    mergeListsWithoutDuplicates = function(tbl1, tbl2, str1: string?)
        if not tbl2 or #tbl2 == 0 then
            return tbl1 or {}
        end
        if not tbl1 or #tbl1 == 0 then
            return tbl2
        end

        local var1 = Cryo.List.toSet(Cryo.List.map(tbl1, function(arg1)
            return if str1 then arg1[str1] else arg1
        end))

        local var2 = Cryo.List.filter(tbl2, function(arg1): boolean
            if str1 then
                arg1 = arg1[str1]
            end

            return not var1[arg1]
        end)

        return Cryo.List.join(table.clone(tbl1), var2)
    end
}
