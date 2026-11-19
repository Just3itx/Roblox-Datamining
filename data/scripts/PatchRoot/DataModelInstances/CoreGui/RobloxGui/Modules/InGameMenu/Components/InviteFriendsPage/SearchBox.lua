-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParentParent = script.Parent.Parent.Parent

local Assets = require(scriptParentParentParent.Resources.Assets)
local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Image = Foundation.Image

local var3 = Roact.PureComponent:extend("SearchBox")

var3.validateProps = t.strictInterface({
    Size = t.UDim2,
    Position = t.UDim2,
    AnchorPoint = t.Vector2,
    searchUpdated = t.callback,
    searchCleared = t.callback,
    itemRef = t.optional(t.table)
})

function var3.init(arg1)
    arg1.state = { searchText = "" }
end

function var3.renderWithSelectionCursor(arg1, arg2)
    return withLocalization({ searchPlaceholder = "CoreScripts.InGameMenu.InviteFriends.Search" })(function(arg3)
        return withFoundationOrUIBloxStyle(function(tokens)
            return {
                Tokens = tokens,
                Theme = {
                    TextEmphasis = {
                        Color = tokens.Color.Content.Emphasis.Color3,
                        Transparency = tokens.Color.Content.Emphasis.Transparency
                    },
                    IconEmphasis = {
                        Color = tokens.Color.Content.Emphasis.Color3,
                        Transparency = tokens.Color.Content.Emphasis.Transparency
                    },
                    BackgroundUIContrast = {
                        Color = tokens.Color.OverMedia.OverMedia_0.Color3,
                        Transparency = tokens.Color.OverMedia.OverMedia_0.Transparency
                    },
                    Divider = {
                        Color = tokens.Color.Stroke.Emphasis.Color3,
                        Transparency = tokens.Color.Stroke.Emphasis.Transparency
                    }
                },
                Font = {
                    BaseSize = 1,
                    Body = {
                        Font = tokens.Typography.BodyLarge.Font,
                        RelativeSize = tokens.Typography.BodyLarge.FontSize
                    }
                }
            }
        end, function(arg4)
            local textEmphasis = arg4.Theme.TextEmphasis
            local body = arg4.Font.Body

            local bool1 = arg1.state.searchText ~= ""
            local num1 = 49
            if bool1 then
                num1 += 46
            end

            local createElement = Roact.createElement
            local str1 = "TextButton"
            local tbl1 = {
                Size = UDim2.fromOffset(32, 32),
                Position = UDim2.new(1, -7, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                Visible = bool1,
                SelectionImageObject = arg2(var2.SmallPill),
                Selectable = true
            }

            tbl1[Roact.Event.Activated] = function()
                arg1:setState({ searchText = "" })

                arg1.props.searchCleared()
            end
            local tbl2 = {
                UIPadding = Roact.createElement("UIPadding", {
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                    PaddingTop = UDim.new(0, 7),
                    PaddingBottom = UDim.new(0, 7)
                }),
                ClearImage = 0
            }
            local element

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element = Roact.createElement(Image, {
                    Size = UDim2.fromScale(1, 1),
                    Image = Assets.Images.ClearIcon.Image,
                    imageRect = {
                        offset = Assets.Images.ClearIcon.ImageRectOffset,
                        size = Assets.Images.ClearIcon.ImageRectSize
                    },
                    imageStyle = {
                        Color3 = arg4.Theme.IconEmphasis.Color,
                        Transparency = 0
                    }
                })
            else
                element = Roact.createElement(ImageSetLabel, {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    Image = Assets.Images.ClearIcon,
                    ImageColor3 = arg4.Theme.IconEmphasis.Color,
                    Selectable = false
                })
            end

            tbl2.ClearImage = element
            local clearButton = createElement(str1, tbl1, tbl2)

            local createElement2 = Roact.createElement
            local var4 = ImageSetLabel
            local tbl3 = {
                BackgroundTransparency = 1,
                Size = arg1.props.Size,
                Position = arg1.props.Position,
                AnchorPoint = arg1.props.AnchorPoint,
                Image = Assets.Images.RoundedRect.Image,
                ImageColor3 = arg4.Theme.BackgroundUIContrast.Color,
                ImageTransparency = arg4.Theme.BackgroundUIContrast.Transparency,
                ScaleType = Assets.Images.RoundedRect.ScaleType,
                SliceCenter = Assets.Images.RoundedRect.SliceCenter
            }
            local tbl4 = {
                Border = Roact.createElement(ImageSetLabel, {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Image = Assets.Images.RoundedRectBorder.Image,
                    SliceCenter = Assets.Images.RoundedRectBorder.SliceCenter,
                    ScaleType = Assets.Images.RoundedRectBorder.ScaleType,
                    ImageColor3 = arg4.Theme.Divider.Color,
                    ImageTransparency = arg4.Theme.Divider.Transparency
                }),
                SearchIcon = 0,
                TextBox = 0,
                PlaceholderText = 0,
                ClearButton = 0
            }
            local element3

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element3 = Roact.createElement(Image, {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 22, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = Assets.Images.SearchIcon.Image,
                    imageRect = {
                        offset = Assets.Images.SearchIcon.ImageRectOffset,
                        size = Assets.Images.SearchIcon.ImageRectSize
                    },
                    imageStyle = {
                        Color3 = arg4.Theme.IconEmphasis.Color,
                        Transparency = 0
                    }
                })
            else
                element3 = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 22, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = Assets.Images.SearchIcon,
                    ImageColor3 = arg4.Theme.IconEmphasis.Color
                })
            end

            tbl4.SearchIcon = element3

            local createElement3 = Roact.createElement
            local tbl5 = {
                Size = UDim2.new(1, -num1, 1, 0),
                Position = UDim2.new(0, 44, 0, 0),
                PlaceholderText = "",
                Text = arg1.state.searchText,
                ClearTextOnFocus = false,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                TextColor3 = textEmphasis.Color,
                TextTransparency = textEmphasis.Transparency,
                FontFace = normalizeFontFace(arg4.Tokens.Typography.BodyLarge.Font),
                TextSize = body.RelativeSize * arg4.Font.BaseSize,
                TextWrapped = false,
                SelectionImageObject = arg2(var2.InputFields)
            }
            tbl5[Roact.Change.Text] = function(arg5)
                if arg1.state.searchText ~= arg5.Text then
                    arg1:setState({ searchText = arg5.Text })

                    arg1.props.searchUpdated(arg5.Text)
                end
            end
            tbl5[Roact.Ref] = arg1.props.itemRef
            tbl4.TextBox = createElement3("TextBox", tbl5)

            tbl4.PlaceholderText = Roact.createElement(ThemedTextLabel, {
                themeKey = "TextEmphasis",
                fontKey = "Body",
                Text = arg3.searchPlaceholder,
                Size = UDim2.new(1, -44, 1, 0),
                Position = UDim2.new(0, 44, 0, 0),
                TextTransparency = 0.5,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2,
                Visible = arg1.state.searchText == ""
            })

            tbl4.ClearButton = clearButton
            return createElement2(var4, tbl3, tbl4)
        end)
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return var3
