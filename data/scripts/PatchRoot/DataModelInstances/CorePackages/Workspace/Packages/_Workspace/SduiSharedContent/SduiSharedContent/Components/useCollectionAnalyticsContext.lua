-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Cryo = require(SduiSharedContentParent.Cryo)
local _UnifiedLogging = require(SduiSharedContentParent.UnifiedLogging)

local SduiCollectionAnalyticsBuilder = require(SduiSharedContentParent.SduiCoreSystem).SduiCollectionAnalyticsBuilder

local tbl1 = {}

local function useCollectionAnalyticsContext(arg1, arg2, num1: number, num2: number, arg3, num3: number?, bool1: boolean?)
    local var1 = React.useRef(nil)

    var1.current = React.useMemo(function()
        return SduiCollectionAnalyticsBuilder.buildAndValidateCollectionAnalyticsData(
            arg3,
            arg1.ancestorAnalyticsData,
            arg1.analyticsData,
            arg2,
            num1,
            num2,
            nil,
            arg2,
            num3
        )
    end, {
        arg3,
        arg1,
        num1,
        num2,
        arg2,
        num3
    })

    return React.useMemo(function()
        local function getCollectionData()
            return var1.current
        end

        if arg1 and bool1 then
            arg1.getCollectionData = getCollectionData
        end

        return Cryo.Dictionary.join(arg1 or tbl1, { getCollectionData = getCollectionData })
    end, { var1, arg1, bool1 }), var1
end

return useCollectionAnalyticsContext
