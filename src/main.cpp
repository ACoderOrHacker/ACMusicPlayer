#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQmlContext>
#include <QFont>
#include <QJSEngine>
#include <husapp.h>

#include "versionqml.h"
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

    MPlayerVersion versionQml;
    qmlRegisterType<MPlayerVersion>("PlayerCpp", 0, 1, "MPlayerVersion");

    QQmlApplicationEngine engine;
    HusApp::initialize(&engine);
    engine.rootContext()->setContextProperty("version", &versionQml);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ACMusicPlayer", "Main");

    return app.exec();
}
