-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local FoundationText = Foundation.Text
local View = Foundation.View

local function makeStepStub(str1: string)
    local function StepStub(_)
        return React.createElement(View, { tag = "col align-x-center align-y-center size-full" }, {
            Label = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-medium text-align-x-center content-default",
                    Text = `{str1} placeholder`
                }
            )
        })
    end
    return StepStub
end

return makeStepStub
