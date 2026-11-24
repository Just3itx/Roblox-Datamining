-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local React = require(GenericChallengesParent.React)

local DeniedChallenge = require(script.Parent.DeniedChallenge)
local DeniedMetadata = require(script.Parent.DeniedMetadata)
local dismissDefaultLoadingGui = require(script.Parent.Parent.Common.dismissDefaultLoadingGui)
local mountNativeChallenge = require(script.Parent.Parent.Common.mountNativeChallenge)

local function shouldShutdownOnTeardown(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.prompt == DeniedMetadata.DeniedPrompt.WasmGameJoinRedirect
end

local function shouldUseOpaqueBackdrop(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.prompt == DeniedMetadata.DeniedPrompt.WasmGameJoinRedirect
end

return function(tbl1)
    local shutdownOnTeardown = not not shouldShutdownOnTeardown(tbl1)

    mountNativeChallenge({
        challengeId = tbl1.challengeId,
        shutdownOnTeardown = shutdownOnTeardown,
        mount = tbl1.mount,
        render = function(callback)
            return React.createElement(DeniedChallenge, {
                challengeId = tbl1.challengeId,
                reason = tbl1.reason,
                prompt = tbl1.prompt,
                opaqueBackdrop = not not shouldUseOpaqueBackdrop(tbl1),
                logging = tbl1.logging,
                onChallengeLoaded = function(bool2: boolean)
                    if tbl1.onChallengeLoaded then
                        tbl1.onChallengeLoaded(bool2)
                    end
                    if bool2 then
                        dismissDefaultLoadingGui(tbl1.replicatedFirst)
                    end
                end,
                onChallengeAbandoned = function()
                    if tbl1.onChallengeAbandoned and not shutdownOnTeardown then
                        tbl1.onChallengeAbandoned()
                    end
                    callback()
                end
            })
        end
    })
end
