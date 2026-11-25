-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local Cryo = require(SduiSharedUtilitiesParent.Cryo)
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local function createSduiTemplateStore()
    local tbl1 = {}

    local tbl2 = ({})
    local tbl3 = ({})

    return {
        getTemplate = function(str1: string)
            return tbl1[str1]
        end,
        addTemplates = function(tbl4)
            tbl1 = Cryo.Dictionary.join(tbl1, tbl4)
        end,
        recordSurfaceTemplates = function(str1: string, tbl4)
            if tbl4 == nil then
                return
            end
            local tbl5 = tbl2[str1]
            if tbl5 == nil then
                tbl5 = {}
                tbl2[str1] = tbl5
            end
            for value, value2 in tbl4 do
                tbl5[value] = value2
            end
        end,
        getCachedRobloxComponentToTemplateId = function(str1: string)
            local var1 = tbl2[str1]
            return if var1 == nil then {} else var1
        end,
        getTemplateForRobloxComponent = function(str1: string, str2: string)
            local var1 = tbl2[str1]
            if var1 == nil then
                return nil
            end
            local var2 = var1[str2]
            return if var2 == nil then nil else tbl1[var2]
        end,
        getSurfaceTemplateMaps = function(str1: string)
            local tbl4 = ({})
            local tbl5 = ({})
            local var1 = tbl2[str1]
            if var1 == nil then
                return tbl4, tbl5
            end
            for value, value2 in var1 do
                local var2 = tbl1[value2]
                if var2 then
                    tbl5[value] = var2
                    tbl4[value2] = var2
                end
            end
            return tbl4, tbl5
        end,
        addLocalizedLiterals = function(tbl4)
            tbl3 = tbl3 or {}
            assert(tbl3, "localizedLiterals is nil")
            for value, value2 in tbl4 do
                tbl3[value] = value2
            end
        end,
        getLocalizedLiterals = function()
            return tbl3 or {}
        end,
        clear = function()
            tbl1 = {}
            tbl2 = {}
            tbl3 = {}
        end
    }
end

local var1 = nil

local function getSduiTemplateStore()
    if var1 == nil then
        var1 = createSduiTemplateStore()
    end
    return var1
end

return getSduiTemplateStore
