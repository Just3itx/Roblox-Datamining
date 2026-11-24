-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local Foundation = require(CoreScriptsRoactCommonParent.Foundation)
local Impressions = require(CoreScriptsRoactCommonParent.Impressions)
local Localization = require(CoreScriptsRoactCommonParent.Localization)
local React = require(CoreScriptsRoactCommonParent.React)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local ImpressionsTagUtility = Impressions.ImpressionsTagUtility
local useLocalization = Localization.Hooks.useLocalization

return React.memo(React.forwardRef(function(tbl1, arg1) -- name: TraversalExperienceCard
    local var1 = Foundation.Hooks.useTokens()

    local foreground = var1.Color.ActionStandard.Foreground
    local size2500 = var1.Size.Size_2500
    local var2 = if typeof(tbl1.width) == "table" then tbl1.width:map(function(num1: number?): UDim2
        return UDim2.fromOffset(num1 or size2500, 0)
    end) else UDim2.fromOffset(tbl1.width or size2500, 0)

    local var3 = if tbl1.rating then useLocalization({ ratingText = { "Feature.GameDetails.RatingPercentOnly", percentRating = tbl1.rating } }) else nil
    local var4 = React.useRef(nil)
    local ref = React.useCallback(function(current)
        var4.current = current
        if typeof(arg1) == "function" then
            arg1(current)
        elseif typeof(arg1) == "table" then
            arg1.current = current
        end
    end, {})

    React.useEffect(function()
        if var4.current and tbl1.impressionTag and tbl1.impressionIndex then
            ImpressionsTagUtility.AddTag(var4, tbl1.impressionTag, tbl1.impressionIndex)
            return function()
                ImpressionsTagUtility.RemoveTag(var4, tbl1.impressionTag, tbl1.impressionIndex)
            end
        end
    end, { tbl1.impressionTag, tbl1.impressionIndex })

    return React.createElement(
        View,
        {
            tag = "auto-y align-x-center align-y-top col radius-medium",
            Size = var2,
            onActivated = tbl1.onActivated,
            ref = ref
        },
        {
            PlaceIcon = if tbl1.image then React.createElement(Image, { Image = tbl1.image, tag = "size-full-full radius-medium aspect-1-1", style = foreground }) else nil,
            Text = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y col gap-xsmall padding-y-medium",
                    textStyle = foreground
                },
                {
                    Name = React.createElement(
                        FoundationText,
                        {
                            tag = "size-full-0 auto-y text-truncate-split text-title-medium text-align-x-left",
                            Text = tbl1.name
                        }
                    ),
                    Rating = tbl1.rating
                        and React.createElement(
                            FoundationText,
                            {
                                tag = "size-full-0 auto-y text-truncate-end text-align-x-left text-body-medium ",
                                Text = var3.ratingText
                            }
                        )
                }
            )
        }
    )
end))
