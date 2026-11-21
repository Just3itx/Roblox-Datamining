-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local UserInputService = game:GetService("UserInputService")

local React = require(EditProfileParent.React)
local UIBlox = require(EditProfileParent.UIBlox)
local normalizeFontFace = require(EditProfileParent.Foundation).Utility.normalizeFontFace
local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local SocialNetworksInEditProfileIXP = require(EditProfile.Flags.SocialNetworksInEditProfileIXP)
local useScreenSize = require(EditProfileParent.RobloxAppHooks).useScreenSize

local CallbackInputBox = require(EditProfileParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Components.CallbackInputBox

local function EditSocialNetworksItem(tbl1)
    local inputBoxRef = React.useRef(nil)

    local var2 = useStyle()
    local font = var2.Font
    local theme = var2.Theme
    local var3 = font.BaseSize * font.Body.RelativeSize
    local var4 = useScreenSize()

    local var5 = SocialNetworksInEditProfileIXP.useGetExperimentVariant({ isExposureEnabled = true })
    local isVisibilityNoOne = if var5 then var5 == SocialNetworksInEditProfileIXP.Variants.VisibilityFirst and tbl1.isVisibilityNoOne else nil

    local var6 = React.useCallback(function()
        if not UserInputService.OnScreenKeyboardVisible then
            tbl1.setKeyboardOffset(0)
            return
        end

        if not inputBoxRef.current or not inputBoxRef.current:IsFocused() then
            return
        end

        local var6 = UserInputService.OnScreenKeyboardPosition.Y - (inputBoxRef.current.AbsolutePosition.Y + inputBoxRef.current.AbsoluteSize.Y)
        if var6 < 0 then
            tbl1.setKeyboardOffset(var6)
            return
        end
        tbl1.setKeyboardOffset(0)
    end, { var4, tbl1.setKeyboardOffset })

    React.useEffect(function()
        local tbl2 = { UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(var6), UserInputService:GetPropertyChangedSignal("OnScreenKeyboardSize"):Connect(var6) }

        if tbl1.focusOn then
            task.spawn(function()
                if inputBoxRef and inputBoxRef.current then
                    inputBoxRef.current:captureFocus()
                end
            end)
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { var6 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.layoutOrder,
        Interactable = not isVisibilityNoOne
    }
    local tbl3 = {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 12)
            }
        ),
        Padding = React.createElement("UIPadding", {
            PaddingTop = if var5 == SocialNetworksInEditProfileIXP.Variants.VisibilityFirst then UDim.new(0, 12) else nil,
            PaddingBottom = if var5 == SocialNetworksInEditProfileIXP.Variants.VisibilityLast then UDim.new(0, 12) else nil
        }),
        NetworkLabel = React.createElement("TextLabel", {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
            Text = tbl1.networkTitle,
            TextSize = var3,
            TextColor3 = theme.TextDefault.Color,
            AutomaticSize = Enum.AutomaticSize.XY,
            RichText = true
        }),
        InputBackground = 0
    }

    local createElement2 = React.createElement
    local var7 = ImageSetLabel
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, var3 + 20),
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Image = Images["component_assets/circle_21"],
        ImageColor3 = theme.UIMuted.Color,
        ImageTransparency = theme.UIMuted.Transparency,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 8, 9, 9)
    }
    local tbl5 = { InputBorder = 0 }
    local createElement3 = React.createElement
    local var8 = ImageSetLabel
    local tbl6 = {
        Size = UDim2.new(1, 0, 0, var3 + 20),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Image = Images["component_assets/circle_21_stroke_1"],
        ImageColor3 = theme.Divider.Color,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 8, 9, 9)
    }
    local tbl7 = {
        Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }),
        TextBox = React.createElement(CallbackInputBox, {
            captureFocusOnMount = tbl1.focusOn,
            clearButtonDisabled = false,
            clearButtonSize = IconSize.Small,
            clearIcon = Images["icons/actions/edit/clear_small"],
            clearIconColor3 = theme.IconEmphasis.Color,
            clearIconTransparency = if isVisibilityNoOne then theme.PlaceHolder.Transparency else nil,
            initialInputText = tbl1.initialText,
            inputBoxRef = inputBoxRef,
            inputTextColor3 = theme.TextDefault.Color,
            inputTextSize = var3,
            inputTextTransparency = if isVisibilityNoOne then theme.PlaceHolder.Transparency else theme.TextDefault.Transparency,
            inputTextXAlignment = Enum.TextXAlignment.Left,
            placeholderText = tbl1.placeholderText,
            placeholderTextColor3 = theme.TextDefault.Color,
            placeholderTextTransparency = if isVisibilityNoOne then theme.PlaceHolder.Transparency else nil,
            textChangedCallback = tbl1.textChanged
        })
    }
    tbl5.InputBorder = createElement3(var8, tbl6, tbl7)
    tbl3.InputBackground = createElement2(var7, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return EditSocialNetworksItem
