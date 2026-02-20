#ifndef MEDIAPLAYER_H
#define MEDIAPLAYER_H

#include <QObject>
#include <QQmlEngine>
#include <QMediaPlayer>

//! TODO: Add Windows SMTC Support

class ACMediaPlayer : public QMediaPlayer
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(PlayingOption playingOption READ playingOption WRITE setOption NOTIFY playingOptionChanged FINAL)
    Q_PROPERTY(bool hasMedia READ hasMedia NOTIFY hasMediaChanged FINAL)
public:
    enum PlayingOption {
        Shuffle,
        Repeat,
        Sequence
    };
    Q_ENUM(PlayingOption)
public:
    static ACMediaPlayer *create(QQmlEngine *, QJSEngine *)
    {
        return new ACMediaPlayer;
    }

    PlayingOption playingOption() const;
    void setOption(PlayingOption);

    bool hasMedia() const;
private:
    PlayingOption option = Sequence;
signals:
    void playingOptionChanged(PlayingOption);
    void hasMediaChanged(bool);
private slots:
    void onHasAudioEmitted();
    void onHasVideoEmitted();
};

#endif // MEDIAPLAYER_H
