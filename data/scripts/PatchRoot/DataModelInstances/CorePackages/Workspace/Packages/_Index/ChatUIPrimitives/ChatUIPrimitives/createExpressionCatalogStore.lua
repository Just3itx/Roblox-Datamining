-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Signals = require(ChatUIPrimitivesParent.Signals)
local FFlagExpChatUseExpressionCatalogNormalizer = require(ChatUIPrimitives.Flags.FFlagExpChatUseExpressionCatalogNormalizer)
local normalizeExpressionCatalog = require(ChatUIPrimitives.PresetChat.normalizeExpressionCatalog)
local normalizePresetCatalog = require(ChatUIPrimitives.PresetChat.normalizePresetCatalog)
local presetCatalogToExpressionCatalog = require(ChatUIPrimitives.PresetChat.presetCatalogToExpressionCatalog)
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)

local createSignal = Signals.createSignal

local function createExpressionCatalogStore(func1: (...any) -> (...any))
    local GameSettings = UserSettings().GameSettings

    local getStatus, var2 = createSignal("disabled")

    local getCategoryGroups, var4 = createSignal({})
    local getIsLoading, var6 = createSignal(false)

    local num1 = 0
    local tbl1 = {}

    local num2 = 0

    local function refresh() -- Luacid: Inlined by compiler; 1 call site recovered
        num2 += 1
        local num3 = num2
        var6(true)
        task.spawn(function()
            local var7 = func1()
            if num3 ~= num2 then
                return
            end
            var6(false)
            if FFlagExpChatUseExpressionCatalogNormalizer then
                local var8 = if var7 == nil then nil else normalizeExpressionCatalog(var7)

                if var8 == nil then
                    return
                end
                var2(var8.status)
                var4(var8.categoryGroups)
                return
            end

            local var8 = if var7 == nil then nil else normalizePresetCatalog(var7)

            if var8 == nil then
                return
            end
            local var9 = presetCatalogToExpressionCatalog(var8)
            var2(var9.status)
            var4(var9.categoryGroups)
        end)
    end

    return {
        getStatus = getStatus,
        getCategoryGroups = getCategoryGroups,
        getIsLoading = getIsLoading,
        acquire = function()
            num1 += 1
            if num1 == 1 then
                refresh()
                table.insert(tbl1, GameSettings:GetPropertyChangedSignal("ChatTranslationLocale"):Connect(refresh))

                table.insert(tbl1, GameSettings:GetPropertyChangedSignal("ChatTranslationEnabled"):Connect(refresh))
            end
        end,
        release = function()
            num1 -= 1
            if not (num1 <= 0) then
                return
            end

            num1 = 0
            for _, value in tbl1 do
                value:Disconnect()
            end
            table.clear(tbl1)

            num2 += 1

            var6(false)
        end,
        _resetForTesting = function()
            for _, value in tbl1 do
                value:Disconnect()
            end
            table.clear(tbl1)
            num1 = 0
            num2 += 1
            var2("disabled")
            var4({})
            var6(false)
        end
    }
end
return createExpressionCatalogStore
