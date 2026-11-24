-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Cryo = require(GenericAbuseReportingParent.Cryo)
local React = require(GenericAbuseReportingParent.React)
local UIBlox = require(GenericAbuseReportingParent.UIBlox)
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization
local DropdownMenu = UIBlox.App.Menu.DropdownMenu

local function ReasonDropdown(tbl1)
    local var1 = React.useMemo(function()
        local var1 = Cryo.Dictionary.map(tbl1.options, function(arg1)
            return arg1.localizationKey, arg1.value
        end)

        return Cryo.Dictionary.union(var1, { ChooseOne = "Feature.ReportAbuse.Label.ChooseOne" })
    end, { tbl1.options })

    local var2 = React.useMemo(function()
        return (Cryo.Dictionary.map(tbl1.options, function(arg1)
            return arg1.descriptionLocalizationKey, arg1.value
        end))
    end, { tbl1.options })

    local var3 = useLocalization(var1)
    local var4 = useLocalization(var2)

    local cellDatas = React.useMemo(function()
        return Cryo.List.map(tbl1.options, function(arg1)
            return {
                text = var3[arg1.value] or "",
                key = arg1.value
            }
        end)
    end, { tbl1.options, var3 })

    local onChange = React.useCallback(function(arg1)
        tbl1.setDropdownError(false)
        tbl1.onSelectedAbuseType(arg1)
        if tbl1.setDescription then
            tbl1.setDescription(var4[arg1] or "")
        end
    end, { tbl1.setDropdownError, tbl1.onSelectedAbuseType })

    return React.createElement(DropdownMenu, {
        placeholder = var3.ChooseOne,
        onChange = onChange,
        screenSize = tbl1.screenSize,
        height = UDim.new(0, tbl1.menuItemHeight),
        fixedListHeight = math.min(tbl1.menuItemHeight * #tbl1.options, tbl1.maxHeight),
        errorState = tbl1.isDropdownError,
        showDropShadow = true,
        dropdownMenuListPositionFixed = true,
        cellDatas = cellDatas,
        defaultKey = tbl1.reportCategoryDefaultKey,
        isDisabled = tbl1.isDisabled
    })
end

return ReasonDropdown
