#include "versionqml.h"

MPlayerVersion::MPlayerVersion(QObject *parent)
    : QObject{parent}
{}

QString MPlayerVersion::getMajor() const
{
    return QString(mplayer::version::major);
}

QString MPlayerVersion::getMinor() const
{
    return QString(mplayer::version::minor);
}

QString MPlayerVersion::getPatch() const
{
    return QString(mplayer::version::patch);
}

QString MPlayerVersion::getFull() const
{
    return QString(mplayer::version::version);
}
