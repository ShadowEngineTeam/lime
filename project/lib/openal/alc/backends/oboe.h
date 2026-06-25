#ifndef BACKENDS_OBOE_H
#define BACKENDS_OBOE_H

#include "base.h"

struct OboeBackendFactory final : BackendFactory {
    auto init() -> bool final;

    auto querySupport(BackendType type) -> bool final;

    auto enumerate(BackendType type) -> std::vector<std::string> final;

    auto createBackend(gsl::not_null<DeviceBase*> device, BackendType type) -> BackendPtr final;

    auto queryEventSupport(alc::EventType eventType, BackendType type) -> alc::EventSupport final;

    static auto getFactory() -> BackendFactory&;
};

#endif /* BACKENDS_OBOE_H */
