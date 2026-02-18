#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QFont>
#include <QJSEngine>
#include <husapp.h>

#include "version.h"

int main(int argc, char *argv[])
{
    QQuickWindow::setDefaultAlphaBuffer(true);

    QGuiApplication app(argc, argv);
    QFont font;
    app.setApplicationName("ACMusic Player");
    app.setApplicationDisplayName("Music Player");
    app.setApplicationVersion(QString(mplayer::version::version));
    font.setPointSize(11);
    app.setFont(font);

    QQmlApplicationEngine engine;
    HusApp::initialize(&engine);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ACMusicPlayer", "Main");

    return app.exec();
}
