-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local PeopleService = require(PeopleReactViewParent.PeopleService)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local Constants = require(PeopleReactView.Constants)

local Button = Foundation.Button
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local useSignalState = SignalsReact.useSignalState

local function PlatformNameSection(tbl1)
    local var1 = useTokens()

    local var2 = React.useMemo(function()
        return PeopleService.getService("PeopleUtility")
    end, {})

    local var3 = React.useMemo(function()
        return PeopleService.getService("PeopleListStore")
    end, {})

    local var4 = React.useMemo(function()
        return var3.getPlatformName(tbl1.UserId)
    end, { tbl1.UserId })

    local var5 = React.useMemo(function()
        return var3.getPlatformProfileId(tbl1.UserId)
    end, { tbl1.UserId })

    local text = useSignalState(var4)
    local var7 = useSignalState(var5)

    local selectable = React.useMemo(function()
        return var2.canShowPlatformProfile(var7)
    end, { var7 })

    local onActivated = React.useCallback(function()
        var2.showPlatformProfile(var7)
    end, { var7 })

    local var10 = React.useRef(nil)

    local ref = React.useCallback(function(arg1)
        var10.current = arg1

        if arg1 and selectable then
            arg1.NextSelectionLeft = arg1
            arg1.NextSelectionRight = nil
        end
    end, { selectable })

    if not text or type(text) ~= "string" or not (string.len(text) > 0) then
        return nil
    end

    return React.createElement(View, {
        tag = "row gap-xsmall align-y-center auto-x size-0-full",
        LayoutOrder = -1
    }, {
        PlatformIconContainer = React.createElement(View, { tag = "auto-xy", LayoutOrder = 1 }, {
            PlatformIcon = React.createElement("ImageLabel", {
                Image = Constants.PEOPLEPAGE.PERSON_ROW.PLATFORM_LOGO_IMAGE,
                Size = UDim2.fromOffset(var1.Size.Size_900, var1.Size.Size_900),
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                ImageColor3 = var1.Color.Content.Default.Color3
            })
        }),
        PlatformNameButton = React.createElement(Button, {
            onActivated = onActivated,
            text = text,
            variant = ButtonVariant.Text,
            size = ButtonSize.Small,
            isDisabled = not selectable,
            Selectable = selectable,
            LayoutOrder = 2,
            ref = ref
        })
    })
end

return PlatformNameSection
