#include "mediaplayer.h"

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

void ACMediaPlayer::onHasAudioEmitted()
{
    emit hasMediaChanged(hasMedia());
}

void ACMediaPlayer::onHasVideoEmitted()
{
    emit hasMediaChanged(hasMedia());
}
