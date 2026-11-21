-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Signals = require(ChatUIPrimitivesParent.Signals)
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

local createSignal = Signals.createSignal

local tbl1 = {}

local function createExpressionCatalogResource(callback: (...any) -> (...any))
    local GameSettings = UserSettings().GameSettings

    local getCatalog, var2 = createSignal(nil)

    local num1 = 0
    local tbl2 = {}

    local num2 = 0

    local function refresh() -- Luacid: Inlined by compiler; 1 call site recovered
        num2 += 1
        local num3 = num2
        task.spawn(function()
            local success, result = pcall(callback)
            if num3 ~= num2 or not success then
                return
            end
            var2(result)
        end)
    end

    return {
        getCatalog = getCatalog,
        acquire = function()
            num1 += 1
            if num1 > 1 then
                return
            end

            refresh()
            table.insert(tbl1, refresh)
            table.insert(tbl2, GameSettings:GetPropertyChangedSignal("ChatTranslationLocale"):Connect(refresh))
            table.insert(tbl2, GameSettings:GetPropertyChangedSignal("ChatTranslationEnabled"):Connect(refresh))
        end,
        release = function()
            if num1 == 0 then
                return
            end
            num1 -= 1
            if num1 > 0 then
                return
            end
            for _, value in tbl2 do
                value:Disconnect()
            end
            table.clear(tbl2)
            local var3 = table.find(tbl1, refresh)
            if var3 ~= nil then
                table.remove(tbl1, var3)
            end
            num2 += 1
        end
    }
end

return (setmetatable({
    _notifySettingsChangedForTesting = function() -- name: notifySettingsChangedForTesting
        for _, value in (table.clone(tbl1)) do
            value()
        end
    end
}, {
    __call = function(_, callback: (...any) -> (...any))
        return (createExpressionCatalogResource(callback))
    end
}))
