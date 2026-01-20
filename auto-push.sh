#!/bin/bash
# Auto-push script for Vortex Site
# Watches for file changes and automatically commits + pushes to GitHub

cd "/Users/nathanstievenard/Desktop/Vortex Site"

echo "🔄 Auto-push activé pour Vortex Site"
echo "📁 Surveillance de: $(pwd)"
echo "🌐 Remote: $(git remote get-url origin)"
echo "---"
echo "Appuyez sur Ctrl+C pour arrêter"
echo ""

fswatch -o -e "\.git" -e "auto-push\.sh" . | while read change; do
    sleep 1  # Petit délai pour regrouper les changements

    # Vérifier s'il y a des changements
    if [[ -n $(git status --porcelain) ]]; then
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        echo "[$timestamp] Changements détectés..."

        git add .
        git commit -m "Auto-update: $timestamp"

        if git push origin main; then
            echo "[$timestamp] ✅ Push réussi!"
        else
            echo "[$timestamp] ❌ Erreur lors du push"
        fi
        echo ""
    fi
done
