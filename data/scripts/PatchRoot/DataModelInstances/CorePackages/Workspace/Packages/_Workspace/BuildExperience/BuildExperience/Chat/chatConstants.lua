-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)

local ASSISTANT_STATUS_SWAP_INTERVAL_SECONDS = game:DefineFastInt("BuildExperienceAssistantStatusSwapIntervalSeconds", 10)

local ASSISTANT_THINKING_DURATION_SUFFIX_DELAY_SECONDS = game:DefineFastInt("BuildExperienceAssistantThinkingDurationSuffixDelaySeconds", 10)
local PROMPT_STALL_SECONDS = game:DefineFastInt("BuildExperiencePromptStallSeconds", 20)

return {
    BUILD_CHAT_PAGE_TITLE = LocalizationStrings.CHAT_BUILD_CHAT_PAGE_TITLE,
    ASSISTANT_LOADING_TEXT = LocalizationStrings.CHAT_ASSISTANT_LOADING,
    ASSISTANT_STILL_WORKING_TEXT = LocalizationStrings.CHAT_ASSISTANT_STILL_WORKING,
    ASSISTANT_STATUS_SWAP_INTERVAL_SECONDS = ASSISTANT_STATUS_SWAP_INTERVAL_SECONDS,
    ASSISTANT_THINKING_DURATION_SUFFIX_DELAY_SECONDS = ASSISTANT_THINKING_DURATION_SUFFIX_DELAY_SECONDS,
    PROMPT_STALL_SECONDS = PROMPT_STALL_SECONDS,
    CAS_RPC_TIMEOUT_SECONDS = 30,
    MESSAGE_LAYOUT_ORDER_STRIDE = if FFlagBuildAdUpsell then 10 else 1,
    THINKING_GRADIENT_ANIMATION_SPEED = 1.4,
    THINKING_GRADIENT_OFFSET = 3,
    BOTTOM_SCROLL_THRESHOLD = 24,
    PUBLISH_PLACE_TOOL_IDENTIFIERS = { "studio_save_and_publish", "cas_save_and_publish" }
}
