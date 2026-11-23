-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)
local SupportedTelemetryBackends = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends
local EventTypes = SocialLuaAnalytics.Analytics.Enums.EventTypes
local Contexts = SocialLuaAnalytics.Analytics.Enums.Contexts

local EventNames = require(script.Parent.EventNames)

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("CapturesTelemetryThrottlingThousandths", 1000),
        links = ""
    },
    [EventNames.CapturesActivatedInGameMenu] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesActivatedChrome] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesCarouselOpened] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesCarouselVideoExpanded] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesCarouselVideoMuteButtonActivated] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesCarouselVideoShrank] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesDeactivatedInGameMenu] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesDeactivatedChrome] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesEntrypointActivated] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                entrypointType = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.CapturesEntrypointLatency] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryStat
        }}
    },
    [EventNames.CapturesLegacyVideoRecordingDuration] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryStat
        }}
    },
    [EventNames.CapturesPageOpenedInGameMenu] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesShareFromNonStandardServer] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesShareLatency] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryStat,
            dynamicCustomFields = {
                externalShareSource = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.CapturesShareToastButtonActivated] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturesVideoCaptureStarted] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                triggerType = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.CapturesVideoCaptureStopped] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = {
                triggerType = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.ShareCaptureGenerateLinkFailed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.ShareCapturePromptAccepted] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.ShareCapturePromptRejected] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturePermissionsPromptAccepted] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturePermissionsPromptRejected] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.CapturePermissionsPromptViewed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter
        }}
    },
    [EventNames.XExpEditingFlowDescriptionEdited] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowDescriptionEdited
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowGalleryItemSelected] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowGalleryItemSelected
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowGalleryNoCapturesAvailable] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.UserSeen
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowGalleryNoCapturesAvailable
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowMusicBackButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowMusicBackButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowMusicButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowMusicButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowMusicDoneButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowMusicDoneButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowMusicSelected] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowMusicSelected
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end,
                musicAssetId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowNextButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowNextButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end,
                editFlowState = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowReturnButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowReturnButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end,
                editFlowState = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowTextOverlayBackButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowTextOverlayBackButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowTextOverlayButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowTextOverlayButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowTextOverlayDoneButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowTextOverlayDoneButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowTrimBackButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowTrimBackButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowTrimButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowTrimButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpEditingFlowTrimDoneButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpEditingFlowTrimDoneButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpMomentCreationStarted] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpMomentCreationStarted
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpMomentsEditingFlowContinueToDescriptionButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpMomentsEditingFlowContinueToDescriptionButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpMomentsEditingFlowContinueToEditButtonPressed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpMomentsEditingFlowContinueToEditButtonPressed
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpMomentsEditingFlowExited] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.UserSeen
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpMomentsEditingFlowExited
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.XExpMomentsEditingFlowPublished] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.UserSeen
            end,
            staticCustomFields = {
                eventContext = Contexts.Moments,
                action = EventNames.XExpMomentsEditingFlowPublished
            },
            dynamicCustomFields = {
                creationSessionId = function<T>(arg1: T): T
                    return arg1
                end
            }
        }}
    },
    [EventNames.CapturesCreateMomentToastViewed] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.UserSeen
            end,
            staticCustomFields = {
                eventContext = Contexts.Captures,
                btn = EventNames.CapturesCreateMomentToastViewed
            }
        }}
    },
    [EventNames.CapturesCreateMomentToastButtonActivated] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Captures,
                btn = EventNames.CapturesCreateMomentToastButtonActivated
            }
        }}
    },
    [EventNames.CapturesCreateMomentToastDownloadActivated] = {
        backendsList = {{
            type = SupportedTelemetryBackends.EventIngest,
            overrideName = function()
                return EventTypes.ButtonClick
            end,
            staticCustomFields = {
                eventContext = Contexts.Captures,
                btn = EventNames.CapturesCreateMomentToastDownloadActivated
            }
        }}
    }
}
