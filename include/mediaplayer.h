#ifndef MEDIAPLAYER_H
#define MEDIAPLAYER_H

#include <QObject>
#include <QQmlEngine>
#include <QMediaPlayer>
#include <QAudioOutput>

//! TODO: Add Windows SMTC Support

class ACMediaPlayer : public QMediaPlayer
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(PlayingOption playingOption READ playingOption WRITE setOption NOTIFY playingOptionChanged FINAL)
    Q_PROPERTY(bool hasMedia READ hasMedia NOTIFY hasMediaChanged FINAL)
    Q_PROPERTY(QUrl coverUrl READ coverUrl WRITE setCoverUrl NOTIFY coverUrlChanged FINAL)
public:
    enum PlayingOption {
        Shuffle,
        Repeat,
        Sequence
    };
    Q_ENUM(PlayingOption)
public:
    explicit ACMediaPlayer(QObject *parent = nullptr);

    PlayingOption playingOption() const;
    void setOption(PlayingOption);

    bool hasMedia() const;

    QUrl coverUrl() const;
    void setCoverUrl(QUrl);
private:
    PlayingOption option = Sequence;
    QUrl coverImgUrl = QUrl();
signals:
    void playingOptionChanged(PlayingOption);
    void hasMediaChanged(bool);
    void coverUrlChanged(QUrl);
private slots:
    void onHasAudioEmitted();
    void onHasVideoEmitted();
};

#endif // MEDIAPLAYER_H
