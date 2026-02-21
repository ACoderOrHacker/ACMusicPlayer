#include "mediaplayer.h"

ACMediaPlayer::ACMediaPlayer(QObject *parent)
    : QMediaPlayer{parent}
{}

ACMediaPlayer::PlayingOption ACMediaPlayer::playingOption() const
{
    return this->option;
}

void ACMediaPlayer::setOption(ACMediaPlayer::PlayingOption opt)
{
    this->option = opt;
    emit playingOptionChanged(playingOption());
}

bool ACMediaPlayer::hasMedia() const
{
    return hasVideo() || hasAudio();
}

QUrl ACMediaPlayer::coverUrl() const
{
    return this->coverImgUrl;
}

void ACMediaPlayer::setCoverUrl(QUrl url)
{
    this->coverImgUrl = url;
}

void ACMediaPlayer::onHasAudioEmitted()
{
    emit hasMediaChanged(hasAudio() || hasMedia());
}

void ACMediaPlayer::onHasVideoEmitted()
{
    emit hasMediaChanged(hasAudio() || hasMedia());
}
