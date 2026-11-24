-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _Signals = require(DataHydrationParent.Signals)
local t = require(DataHydrationParent.t)

return {
    userVoteFeedbackMetadataResponseValidator = t.interface({
        capabilities = t.interface(
            {
                can_submit_review = t.boolean,
                can_submit_category_options = t.optional(t.boolean),
                can_submit_comment = t.boolean
            }
        ),
        categories = t.array(
            t.interface({
                type = t.string,
                label = t.string,
                allows_multiple_selections = t.boolean,
                options = t.array(t.interface({ id = t.string, label = t.string }))
            })
        ),
        comment = t.interface({ label = t.string, placeholder_text = t.string, minimum_length = t.number, maximum_length = t.number }),
        metadata = t.interface({ disclaimer_label = t.string, submit_button_label = t.string, form_title_label = t.string })
    })
}
