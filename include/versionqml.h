#ifndef VERSIONQML_H
#define VERSIONQML_H

#include <QObject>
#include <QQmlEngine>
#include <QString>
#include "version.h"

class MPlayerVersion : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    static MPlayerVersion *create(QQmlEngine *, QJSEngine *)
    {
        return new MPlayerVersion;
    }

public:
    Q_INVOKABLE QString major() const;
    Q_INVOKABLE QString minor() const;
    Q_INVOKABLE QString patch() const;
    Q_INVOKABLE QString full()  const;
};

#endif // VERSIONQML_H
