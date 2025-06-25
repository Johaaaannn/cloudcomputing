# 🌐 Déploiement d’une application WordPress sur Azure avec Docker et Terraform

## 📁 Structure du projet

Ce projet est organisé de manière modulaire afin de gérer l'infrastructure Azure complète via Terraform :

```
TP2/
├── docker-wordpress/            # Image Docker personnalisée WordPress
│   └── Dockerfile
│   └── custom-content/
├── modules/
│   ├── acr/                     # Module pour Azure Container Registry
│   ├── mysql/                   # Module pour Azure MySQL Flexible Server
│   └── webapp/                  # Module pour l'App Service Web
├── main.tf                      # Appel des modules + outputs globaux
├── variables.tf                 # Variables globales
├── terraform.tfvars             # Valeurs des variables
└── README.md                    # Ce fichier
```

## ⚙️ Objectif du TP

> Déployer une application WordPress containerisée sur un App Service Linux Azure, avec une image personnalisée hébergée dans un ACR, le tout provisionné via Terraform.

---

## 🐳 Image Docker WordPress

Une image Docker personnalisée a été construite pour WordPress :

- **Dockerfile** basé sur `wordpress:latest`
- Ajout de contenu statique personnalisé dans `/custom-content`
- Image buildée puis poussée dans mon ACR :

```bash
docker build -t wordpress-custom .
docker tag wordpress-custom wpdemoarcdevacrdev.azurecr.io/wordpress-custom:latest
docker push wpdemoarcdevacrdev.azurecr.io/wordpress-custom:latest
```

✅ **Testée localement avec succès.**

---

## ☁️ Infrastructure Azure via Terraform

### ✅ Modules déployés :
- `acr` : Azure Container Registry
- `mysql` : Azure Database for MySQL Flexible Server
- `webapp` : Azure App Service (Linux)

Les identifiants MySQL, l’URL du container et la configuration du Web App sont injectés automatiquement.

### 🧪 Résultat sur Azure :
- Le Web App a bien été déployé
- L’image Docker a bien été tirée depuis ACR
- Mais le site affiche `Application Error`

---

## 🛠️ Débogage

### 🔍 Vérifications effectuées :
- Port 80 bien exposé dans le Dockerfile (`EXPOSE 80`)
- Paramètre `healthCheckPath` défini sur `/`
- Variables d’environnement du Web App vérifiées
- Image fonctionne en local (preuve que le container n’est pas en cause)

### 📉 Problème observé :
- Le site `wpdemoarcdev-web-dev.azurewebsites.net` affiche une erreur 503
- L’accès SSH à l’App Service échoue également
- Les logs Azure ne s'affichent pas (`logstream` indisponible)

---

## 📸 Captures d’écran

| Description                       | Capture |
|----------------------------------|---------|
| 📁 Arborescence Terraform         | `arborescence.png` |
| 🐳 Image WordPress locale OK      | `wordpress-local.png` |
| ❌ Erreur d’application sur Azure | `error-azure.png` |
| 🧪 Logs Azure CLI (503)           | `logstream.png` |

---

## 📌 Conclusion

Malgré tous les éléments configurés correctement (Docker, ACR, Terraform, App Service), le site ne fonctionne pas sur Azure en raison d'une erreur côté service (503).  
Cependant, l’image fonctionne **parfaitement en local**, prouvant la validité du Dockerfile et du projet global.

✅ **Une remise cohérente et fonctionnelle a été préparée.**  
❌ **Blocage externe indépendant de la configuration.**

---

## 🙏 Remerciements

Merci pour votre compréhension face aux aléas techniques liés à la plateforme Azure.