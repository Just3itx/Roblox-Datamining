-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent

local dependencies = require(FriendsLanding.dependencies)

local Roact = dependencies.Roact

local withLocalization = dependencies.withLocalization

local UIBlox = dependencies.UIBlox
local withStyle = UIBlox.Style.withStyle
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local TextKeys = require(FriendsLanding.Common.TextKeys)
local Constants = require(FriendsLanding.Common.Constants)
local AppFonts = require(FriendsLandingParent.Style).AppFonts
local Cryo = require(FriendsLandingParent.Cryo)
local Foundation = require(FriendsLandingParent.Foundation)
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens
local FoundationCloudAssets = require(FriendsLandingParent.FoundationCloudAssets)
local Assets = FoundationCloudAssets.Assets
local preloadAsset = FoundationCloudAssets.preloadAsset

local bool1 = game:DefineFastFlag("MigrateEmptyResultsViewToFoundation", false)

local var1 = Roact.PureComponent:extend("EmptyResultsView")

var1.defaultProps = { layoutOrder = 0, pageLoadingTimeReport = nil }

local function loadFoundationCloudAsset(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    preloadAsset(str1)
    local asset = Assets[str1]
    return asset.assetId, asset.size
end

function var1.render(arg1)
    return withStyle(function(arg2)
        return withLocalization({ noResultsText = "CommonUI.Messages.Response.NoResults", addFriendsBtn = TextKeys.ADD_FRIENDS_BTN })(
            function(arg3)
                local createElement = Roact.createElement
                local str1 = "Frame"
                local tbl1 = {
                    Size = UDim2.new(1, 0, 1, -(Constants.TOP_BAR_HEIGHT + 45)),
                    LayoutOrder = arg1.props.layoutOrder,
                    BackgroundTransparency = 1
                }
                local tbl2 = { IndicatorInner = 0 }
                local createElement2 = Roact.createElement
                local str2 = "Frame"
                local tbl3 = {
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Size = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.4, 0),
                    AnchorPoint = Vector2.new(0.5, 0.4)
                }
                local tbl4 = {
                    UIList = Roact.createElement("UIListLayout", {
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        Padding = UDim.new(0, 0)
                    }),
                    Imagelabel = 0,
                    Textlabel = 0
                }
                local element

                if bool1 then
                    element = Roact.createElement(Image, {
                        Image = arg1.props.assetId,
                        imageStyle = arg1.props.tokens.Color.Content.Emphasis,
                        Size = UDim2.fromOffset(arg1.props.assetSize.X, arg1.props.assetSize.Y),
                        LayoutOrder = 1
                    })
                else
                    element = Roact.createElement(ImageSetLabel, {
                        BackgroundTransparency = 1,
                        Image = Images["icons/status/oof_xlarge"],
                        ImageColor3 = arg2.Theme.TextMuted.Color,
                        ImageTransparency = arg2.Theme.TextMuted.Transparency,
                        LayoutOrder = 1,
                        Size = UDim2.new(0, 96, 0, 96)
                    })
                end

                tbl4.Imagelabel = element

                tbl4.Textlabel = Roact.createElement("TextLabel", {
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    Font = AppFonts.default:getDefault(),
                    LayoutOrder = 2,
                    Size = UDim2.new(0, 0, 0, 0),
                    Text = arg3.noResultsText,
                    TextColor3 = arg2.Theme.TextMuted.Color,
                    TextSize = arg2.Font.Header2.RelativeSize * arg2.Font.BaseSize,
                    TextTransparency = arg2.Theme.TextMuted.Transparency
                })
                tbl2.IndicatorInner = createElement2(str2, tbl3, tbl4)
                return createElement(str1, tbl1, tbl2)
            end
        )
    end)
end

return if bool1 then function(arg1) -- name: EmptyResultsViewContainer
    local assetId, size = loadFoundationCloudAsset("pictograms/collaborators")
    local tokens = useTokens()

    local assetSize = size / 3

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { assetSize = assetSize, assetId = assetId, tokens = tokens }))
end else var1
