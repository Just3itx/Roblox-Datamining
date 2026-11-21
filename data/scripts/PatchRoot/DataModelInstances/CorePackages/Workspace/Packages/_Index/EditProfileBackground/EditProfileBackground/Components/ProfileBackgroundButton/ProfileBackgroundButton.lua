-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackground = script:FindFirstAncestor("EditProfileBackground")
local EditProfileBackgroundParent = EditProfileBackground.Parent
local React = require(EditProfileBackgroundParent.React)
local Image = require(EditProfileBackgroundParent.Foundation).Image
local useSelectedTheme = require(EditProfileBackgroundParent.RoactUtils).Hooks.useSelectedTheme
local Constants = require(EditProfileBackground.Common.Constants)

local var1 = Constants.BACKGROUND_ASSET_IDS[1]

local white = Color3.fromRGB(255, 255, 255)
local black = Color3.fromRGB(0, 0, 0)

local darkTaupe = Color3.fromRGB(80, 80, 80)

local black2 = Color3.fromRGB(30, 38, 58)
local cadetBlue = Color3.fromRGB(156, 178, 196)

local tbl1 = {
    [Constants.BACKGROUND_ASSET_IDS[2]] = Color3.fromRGB(255, 242, 216),
    [Constants.BACKGROUND_ASSET_IDS[3]] = Color3.fromRGB(254, 244, 194),
    [Constants.BACKGROUND_ASSET_IDS[4]] = Color3.fromRGB(238, 246, 216),
    [Constants.BACKGROUND_ASSET_IDS[5]] = Color3.fromRGB(214, 254, 202),
    [Constants.BACKGROUND_ASSET_IDS[6]] = Color3.fromRGB(192, 255, 226),
    [Constants.BACKGROUND_ASSET_IDS[7]] = Color3.fromRGB(208, 252, 255),
    [Constants.BACKGROUND_ASSET_IDS[8]] = Color3.fromRGB(238, 244, 255)
}

local function getButtonColor(profileBackgroundId: number, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return if profileBackgroundId == var1 then if str1 == "dark" then black2 else cadetBlue else tbl1[profileBackgroundId]
end

local function ProfileBackgroundButton(tbl2)
    local buttonSize = tbl2.buttonSize
    local var2 = useSelectedTheme()

    local var3 = React.useCallback(function()
        if tbl2.selected then
            return
        end

        if tbl2.onActivated then
            tbl2.onActivated(tbl2.profileBackgroundId)
        end
    end, { tbl2.onActivated, tbl2.selected, tbl2.profileBackgroundId })

    local num1 = math.floor(buttonSize * 0.4)
    local backgroundColor3 = getButtonColor(tbl2.profileBackgroundId, var2)

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl3 = {
        Size = UDim2.new(0, buttonSize, 0, buttonSize),
        BackgroundTransparency = 0,
        BackgroundColor3 = backgroundColor3,
        BorderSizePixel = if tbl2.selected then 3 else 0,
        BorderColor3 = if tbl2.selected then white else black,
        LayoutOrder = tbl2.LayoutOrder,
        [React.Event.Activated] = var3
    }
    local tbl4 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
        Overlay = 0,
        Checkmark = 0
    }
    local element

    if tbl2.selected then
        element = React.createElement(
            "Frame",
            {
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = darkTaupe,
                BackgroundTransparency = 0.5,
                Size = UDim2.fromScale(0.8, 0.8),
                ZIndex = 2
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
            }
        )
            or nil
    else
        element = nil
    end

    tbl4.Overlay = element

    tbl4.Checkmark = if tbl2.selected then React.createElement(Image, {
        tag = "position-center-center anchor-center-center",
        Image = "rbxassetid://6031094667",
        Size = UDim2.fromOffset(num1, num1),
        ZIndex = 3
    })
        or nil else nil
    return createElement(str1, tbl3, tbl4)
end

return ProfileBackgroundButton
