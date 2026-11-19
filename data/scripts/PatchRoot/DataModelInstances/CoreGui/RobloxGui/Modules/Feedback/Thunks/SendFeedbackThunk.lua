-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Promise = require(CorePackages.Packages.InGameMenuDependencies).Promise
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch

local scriptParentParent = script.Parent.Parent

local PostFeedback = require(scriptParentParent.Network.PostFeedback)

local IncrementFeedbackSubmissionAttempts = require(scriptParentParent.Actions.IncrementFeedbackSubmissionAttempts)

return function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    return PerformFetch.Single("PostFeedbackRequest", function(arg9)
        return PostFeedback(arg1, arg2, arg3, arg4, arg5, arg6, arg7):andThen(function(arg10)
            arg9:dispatch(IncrementFeedbackSubmissionAttempts(arg8))
            return Promise.resolve(arg10)
        end, function(arg10)
            return Promise.reject(arg10)
        end)
    end)
end
