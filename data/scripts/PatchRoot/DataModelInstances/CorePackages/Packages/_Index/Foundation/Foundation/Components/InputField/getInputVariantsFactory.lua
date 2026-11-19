-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:01:27Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)

local _Types = require(Foundation.Components.Types)

local InputSize = require(Foundation.Enums.InputSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local _IconSize = require(Foundation.Enums.IconSize)

local Radius = require(Foundation.Enums.Radius)

local _composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local Flags = require(Foundation.Utility.Flags)

local function getInputVariantsFactory(arg1)
    local common = {
        container = {
            fgStyle = if Flags.FoundationFixColorOnScrubbableNumberInput then arg1.Color.Shift.Shift_200 else nil,
            strokeStyle = arg1.Color.Stroke.Emphasis,
            strokeThickness = arg1.Stroke.Standard
        }
    }

    local sizes = {
        [InputSize.XSmall] = {
            container = { tag = "size-full-600" }
        },
        [InputSize.Small] = {
            container = { tag = "size-full-800" }
        },
        [InputSize.Medium] = {
            container = { tag = "size-full-1000" }
        },
        [InputSize.Large] = {
            container = { tag = "size-full-1200" }
        }
    }
    local variants = {
        [InputVariant.Standard] = {},
        [InputVariant.Contrast] = {
            container = {
                fgStyle = if Flags.FoundationFixColorOnScrubbableNumberInput then arg1.Color.Shift.Shift_300 else nil,
                bgStyle = arg1.Color.Shift.Shift_200,
                strokeStyle = Dash.None
            }
        },
        [InputVariant.Utility] = {
            container = {
                fgStyle = Dash.None,
                bgStyle = Dash.None,
                strokeStyle = Dash.None
            }
        }
    }

    local errorState = {
        [true] = {
            container = {
                strokeStyle = arg1.Color.System.Alert
            }
        },
        [false] = {}
    }

    local focusedState = {
        [true] = {
            container = {
                strokeStyle = arg1.Color.System.Emphasis,
                strokeThickness = arg1.Stroke.Standard * 2
            }
        },
        [false] = {}
    }

    local hoverState = {
        [true] = {
            container = {
                strokeThickness = arg1.Stroke.Standard * 2
            }
        },
        [false] = {}
    }

    return {
        common = common,
        sizes = sizes,
        variants = variants,
        defaultRadius = {
            [InputSize.XSmall] = {
                container = {
                    tag = { ["radius-small"] = true }
                }
            },
            [InputSize.Small] = {
                container = {
                    tag = { ["radius-medium"] = true }
                }
            },
            [InputSize.Medium] = {
                container = {
                    tag = { ["radius-medium"] = true }
                }
            },
            [InputSize.Large] = {
                container = {
                    tag = { ["radius-medium"] = true }
                }
            }
        },
        radius = {
            [Radius.None] = {
                container = {
                    tag = { ["radius-none"] = true }
                }
            },
            [Radius.XSmall] = {
                container = {
                    tag = { ["radius-xsmall"] = true }
                }
            },
            [Radius.Small] = {
                container = {
                    tag = { ["radius-small"] = true }
                }
            },
            [Radius.Medium] = {
                container = {
                    tag = { ["radius-medium"] = true }
                }
            },
            [Radius.Large] = {
                container = {
                    tag = { ["radius-large"] = true }
                }
            }
        },
        errorState = errorState,
        focusedState = focusedState,
        hoverState = hoverState
    }
end

return getInputVariantsFactory
