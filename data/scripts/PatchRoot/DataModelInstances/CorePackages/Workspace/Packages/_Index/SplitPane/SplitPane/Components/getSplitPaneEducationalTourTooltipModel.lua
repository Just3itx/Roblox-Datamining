-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Foundation = require(SplitPaneParent.Foundation)

local _SplitPaneEducationalTourSteps = require(script.Parent.SplitPaneEducationalTourSteps)

local getSplitPaneEducationalTourVideoAssetId = require(script.Parent.getSplitPaneEducationalTourVideoAssetId)

local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

return function(tbl1): {align: number, isFinal: boolean, primaryActionText: number, side: number, skipActionText: number, stepIndex: any, text: number, title: number, totalSteps: any, videoAssetId: number}?
    local step = tbl1.step
    if step == nil then
        return nil
    end
    local tbl2 = tbl1.isCollapsedStepOne and not tbl1.isDirectionalInput and {
        side = PopoverSide.Bottom,
        align = PopoverAlign.End
    }
        or tbl1.isDirectionalInput
            and (tbl1.stepIndex == 2 or tbl1.stepIndex == 3)
            and {
                side = PopoverSide.Top,
                align = PopoverAlign.Center
            }
        or tbl1.stepIndex == 1 and {
            side = PopoverSide.Left,
            align = PopoverAlign.Center
        }
        or tbl1.stepIndex == 2 and {
            side = PopoverSide.Top,
            align = PopoverAlign.Center
        }
        or {
            side = PopoverSide.Bottom,
            align = PopoverAlign.End
        }
    local title = if tbl1.stepIndex == 1 then tbl1.localized.stepOneTitle elseif tbl1.stepIndex == 2 then tbl1.localized.stepTwoTitle else tbl1.localized.stepThreeTitle
    local text = if tbl1.stepIndex == 1 then if tbl1.isCollapsedStepOne then tbl1.localized.stepOneCollapsedDescription else tbl1.localized.stepOneExpandedDescription elseif tbl1.stepIndex == 2 then tbl1.localized.stepTwoDescription else tbl1.localized.stepThreeDescription
    return {
        stepIndex = tbl1.stepIndex,
        totalSteps = tbl1.totalSteps,
        isFinal = step.isFinal == true,
        primaryActionText = if step.isFinal then tbl1.localized.finishTourButton else tbl1.localized.continueButton,
        skipActionText = if step.isFinal then nil else tbl1.localized.skipTourButton,
        title = title,
        text = text,
        side = tbl2.side,
        align = tbl2.align,
        videoAssetId = getSplitPaneEducationalTourVideoAssetId(step, tbl1.isDirectionalInput, tbl1.isCollapsedStepOne)
    }
end
