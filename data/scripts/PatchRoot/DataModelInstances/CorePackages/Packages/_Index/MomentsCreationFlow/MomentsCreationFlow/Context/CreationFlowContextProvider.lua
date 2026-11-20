-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Dash = require(MomentsCreationFlowParent.Dash)
local React = require(MomentsCreationFlowParent.React)

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local function CreationFlowContextProvider(tbl1)
    return React.createElement(
        CreationFlowContext.Provider,
        {
            value = Dash.join(tbl1.value, { captures = tbl1.captures, exitCreationFlow = tbl1.exitCreationFlow })
        },
        tbl1.children
    )
end
return CreationFlowContextProvider
