#ifndef VERSION_H
#define VERSION_H

#define ACMUSIC_PLAYER_VERSION_MAJOR "0"
#define ACMUSIC_PLAYER_VERSION_MINOR "0"
#define ACMUSIC_PLAYER_VERSION_PATCH "1"

#define ACMUSIC_PLAYER_VERSION \
    ACMUSIC_PLAYER_VERSION_MAJOR "." ACMUSIC_PLAYER_VERSION_MINOR "." ACMUSIC_PLAYER_VERSION_PATCH

namespace mplayer::version
{
    constexpr const char *major = ACMUSIC_PLAYER_VERSION_MAJOR;
    constexpr const char *minor = ACMUSIC_PLAYER_VERSION_MINOR;
    constexpr const char *patch = ACMUSIC_PLAYER_VERSION_PATCH;
    constexpr const char *version = ACMUSIC_PLAYER_VERSION;
}

#endif // VERSION_H
