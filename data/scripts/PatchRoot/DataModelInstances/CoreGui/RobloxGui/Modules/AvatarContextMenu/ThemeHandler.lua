-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InsertService = game:GetService("InsertService")
local StarterGui = game:GetService("StarterGui")

local Theme = {
    BackgroundImage = "rbxasset://textures/blackBkg_round.png",
    BackgroundImageScaleType = Enum.ScaleType.Slice,
    BackgroundImageSliceCenter = Rect.new(12, 12, 12, 12),
    BackgroundImageTransparency = 0,
    BackgroundTransparency = 1,
    BackgroundColor = Color3.fromRGB(31, 31, 31),
    NameTagColor = Color3.fromRGB(79, 79, 79),
    NameUnderlineColor = Color3.fromRGB(255, 255, 255),
    ButtonFrameColor = Color3.fromRGB(79, 79, 79),
    ButtonFrameTransparency = 0,
    ButtonImage = "",
    ButtonImageScaleType = Enum.ScaleType.Slice,
    ButtonImageSliceCenter = Rect.new(8, 6, 46, 44),
    ButtonColor = Color3.fromRGB(79, 79, 79),
    ButtonTransparency = 1,
    ButtonHoverColor = Color3.fromRGB(163, 162, 165),
    ButtonHoverTransparency = 0.5,
    ButtonUnderlineColor = Color3.fromRGB(137, 137, 137),
    Font = Enum.Font.SourceSansBold,
    TextColor = Color3.fromRGB(255, 255, 255),
    TextScale = 1,
    LeaveMenuImage = "rbxasset://textures/loading/cancelButton.png",
    ScrollRightImage = "rbxasset://textures/ui/AvatarContextMenu_Arrow.png",
    ScrollLeftImage = "",
    SelectedCharacterIndicator = InsertService:LoadLocalAsset("rbxasset://models/AvatarContextMenu/AvatarContextArrow.rbxm"),
    Size = UDim2.new(0.95, 0, 0.9, 0),
    MinSize = Vector2.new(200, 200),
    MaxSize = Vector2.new(300, 300),
    AspectRatio = 1.15,
    AnchorPoint = Vector2.new(0.5, 1),
    OnScreenPosition = UDim2.new(0.5, 0, 0.98, 0),
    OffScreenPosition = UDim2.new(0.5, 0, 1, 300)
}

local tbl2 = {}
tbl2.__index = tbl2

function tbl2:UpdateTheme(arg1)
    local theme = ({})
    for k, value in pairs(Theme) do
        if typeof(arg1[k]) == typeof(value) then
            theme[k] = arg1[k]
        elseif arg1[k] == nil then
            theme[k] = value
        else
            local error = error
            local format = string.format

            local var1 = arg1[k]
            error(format("AvatarContextMenuTheme wrong type for key %s: %s. Expected type %s", k, typeof(var1), typeof(value)), 2)
        end
    end
    self.Theme = theme
end

function tbl2:RegisterCoreMethods()
    StarterGui:RegisterSetCore("AvatarContextMenuTheme", function(arg1) -- name: setMenuTheme
        if type(arg1) ~= "table" then
            error("AvatarContextMenuTheme argument must be a table")

            return
        end

        for k in pairs(arg1) do
            if Theme[k] == nil then
                error(string.format("AvatarContextMenuTheme got invalid key: %s", k))
            end
        end
        self:UpdateTheme(arg1)
    end)
end

function tbl2:GetTheme()
    return self.Theme
end

function tbl2.new()
    local self = setmetatable({}, tbl2)

    self.Theme = Theme

    self:RegisterCoreMethods()

    return self
end

return tbl2.new()
