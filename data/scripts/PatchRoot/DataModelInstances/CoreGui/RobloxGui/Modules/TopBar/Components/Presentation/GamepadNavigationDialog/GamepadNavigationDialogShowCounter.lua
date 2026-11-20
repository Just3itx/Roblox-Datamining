-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local React = require(CorePackages.Packages.React)
local _UIBlox = require(CorePackages.Packages.UIBlox)
local GamepadNavigationDialog = require(script.Parent.GamepadNavigationDialog)
React.PureComponent:extend("GamepadNavigationDialogShowCounter")

local function shouldShowBasedOnCountInAppStorage(key: string, maxShownCount): (boolean, string)
    local item = AppStorageService:GetItem(key)
    local item2 = AppStorageService:GetItem("UserId")
    local success, result = pcall(function()
        return HttpService:JSONDecode(item)
    end)
    local input = (not success or type(result) ~= "table") and {} or result

    local var1 = input[item2]
    local var2 = if type(var1) ~= "number" then 0 else var1

    input[item2] = var2 + 1
    return var2 < maxShownCount, HttpService:JSONEncode(input)
end

local function GamepadNavigationDialogTextButton(tbl1)
    React.useEffect(function()
        return tbl1.onCleanup
    end, {})

    return React.createElement("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        [React.Event.Activated] = tbl1.onDismissed
    }, {
        GamepadNavigationDialog = React.createElement(GamepadNavigationDialog, {
            selectButtonDismissesGamepadNavigationDialog = tbl1.selectButtonDismissesGamepadNavigationDialog,
            onDismissed = tbl1.onDismissed
        })
    })
end

local function GamepadNavigationDialogShowCounter(tbl1)
    if not (tbl1.isGamepadNavigationDialogEnabled and tbl1.isGamepadNavigationDialogOpen) then
        return nil
    end

    local bool1, str1 = shouldShowBasedOnCountInAppStorage(tbl1.appStorageKey, tbl1.maxShownCount)
    if not bool1 then
        return nil
    end

    return React.createElement(GamepadNavigationDialogTextButton, {
        selectButtonDismissesGamepadNavigationDialog = tbl1.selectButtonDismissesGamepadNavigationDialog,
        onDismissed = function()
            tbl1.SetGamepadNavigationDialogOpen(false)
        end,
        onCleanup = function()
            AppStorageService:SetItem(tbl1.appStorageKey, str1)
            AppStorageService:Flush()
        end
    })
end

return GamepadNavigationDialogShowCounter
