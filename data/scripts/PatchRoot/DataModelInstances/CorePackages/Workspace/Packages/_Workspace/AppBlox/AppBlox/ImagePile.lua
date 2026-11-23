-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local Cryo = require(AppBloxParent.Cryo)
local Logger = require(AppBloxParent.Loggers).Logger
local React = require(AppBloxParent.React)
local UIBlox = require(AppBloxParent.UIBlox)

local Core = UIBlox.Core
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = Core.Style.useStyle

local var1 = Logger:new(script.Name)

local function ImagePile(tbl1)
    local tokens = useStyle().Tokens

    local var2 = React.useMemo(function()
        return {
            imageBorderColor = tokens.Color.Extended.White.White_100.Color3,
            imageBorderThickness = tokens.Size.Size_50
        }
    end, { tokens })
    local var3 = Cryo.Dictionary.union(var2, tbl1)

    local var4 = React.useMemo(function()
        return {
            {
                Attribute1 = {
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.fromScale(0, 0),
                    Size = UDim2.fromOffset(tokens.Size.Size_1000, tokens.Size.Size_1000),
                    ZIndex = 1
                }
            },
            {
                Attribute1 = {
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.fromScale(0, 1),
                    Size = UDim2.fromOffset(tokens.Size.Size_700, tokens.Size.Size_700),
                    ZIndex = 2
                },
                Attribute2 = {
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.fromScale(1, 0),
                    Size = UDim2.fromOffset(tokens.Size.Size_700, tokens.Size.Size_700),
                    ZIndex = 1
                }
            }
        }
    end, { tokens })

    local var5 = React.useCallback(function(num1: number, num2: number)
        local num3 = math.min(num1, 2)
        return var4[num3]["Attribute" .. num2]
    end, { var4 })

    local var6 = React.useMemo(function()
        local result = ({})

        for value, value2 in var3.images do
            if value > 2 then
                var1:warning("More than 2 images provided but only the first 2 will be shown.")
                return result
            end

            local var6 = var5(#var3.images, value)
            value2.AnchorPoint = var6.AnchorPoint
            value2.Position = var6.Position
            value2.Size = var6.Size
            value2.ZIndex = var6.ZIndex

            local str1 = tostring(value)
            local createElement = React.createElement
            local var7 = ImageSetLabel
            local tbl2 = {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
                UIStroke = React.createElement(
                    "UIStroke",
                    {
                        Color = var3.imageBorderColor,
                        Thickness = var3.imageBorderThickness,
                        Transparency = 0
                    }
                )
            }
            result[str1] = createElement(var7, value2, tbl2)
        end

        return result
    end, { var3.images })

    if #var3.images == 0 then
        var1:warning("Cannot have empty list of images")
        return nil
    end
    return React.createElement("Frame", {
        [React.Tag] = "data-testid=ImagePile",
        BackgroundTransparency = 1,
        Name = "ImagePile",
        Size = UDim2.fromOffset(tokens.Size.Size_1000, tokens.Size.Size_1000)
    }, var6)
end

return ImagePile
