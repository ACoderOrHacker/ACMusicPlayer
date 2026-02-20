#include "versionqml.h"

QString MPlayerVersion::major() const
{
    return QString(mplayer::version::major);
}

QString MPlayerVersion::minor() const
{
    return QString(mplayer::version::minor);
}

QString MPlayerVersion::patch() const
{
    return QString(mplayer::version::patch);
}

QString MPlayerVersion::full() const
{
    return QString(mplayer::version::version);
}
