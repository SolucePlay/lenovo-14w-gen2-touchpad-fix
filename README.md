# Fix Pavé Tactile / Touchpad Lenovo 14w Gen 2 (Linux)

Correctif pour le bug du **pavé tactile Elan I2C** sur l’ordinateur **Lenovo 14w Gen 2 (AMD)** sous Linux.

---

## 🐞 Problème

Le BIOS de cet appareil ne fournit pas d’interruption (**IRQ**) valide pour le pavé tactile.

Cause :
- La méthode **_CRS** dans la table **DSDT** ne contient pas de retour par défaut
- Linux assigne alors automatiquement **IRQ 0**
- Le pilote échoue à s’initialiser → erreur **-16**

---

## 💡 Solution

Ce dépôt fournit une table **DSDT patchée** qui corrige le comportement ACPI.

Modifications appliquées :
- Forçage de l’adresse I2C : **0x15**
- Attribution correcte de l’interruption GPIO : **0x09**
- Contournement du bug BIOS

---

## 📦 Contenu

- **dsdt.dsl** : Source de la DSDT modifiée  
- **acpi-override.cpio** : Archive prête à être injectée via GRUB  
- **install.sh** : Script d’installation automatique  
- **LICENSE** : **GNU General Public License v2.0**

---

## ⚙️ Installation

### ✔ Option 1 (Recommandée)

`sudo bash install.sh`

---

### 🔧 Option 2 (Manuelle)

1. Copier le fichier :  
   `sudo cp acpi-override.cpio /boot/`

2. Modifier GRUB :  
   `sudo nano /etc/default/grub`

3. Ajouter :  
   `GRUB_EARLY_INITRD_LINUX_CUSTOM="acpi-override.cpio"`

4. Appliquer :  
   `sudo update-grub && sudo reboot`

---

## ⚠️ Avertissements

- Ce correctif modifie le comportement **ACPI** du système
- Une mauvaise configuration peut :
  - empêcher le démarrage
  - provoquer des dysfonctionnements matériels
- Testé uniquement sur :
  - **Lenovo 14w Gen 2 (AMD)**

👉 Utilisation **à vos risques**

---

## 🧪 Compatibilité

Testé sur :
- Linux kernel **5.x / 6.x**
- Distributions :
  - Ubuntu / Debian
  - Arch Linux (non garanti mais compatible GRUB)

Non testé :
- Autres modèles Lenovo
- Versions BIOS différentes

---

## 🔄 Désinstallation / Rollback

Si problème au démarrage :

### Depuis un système fonctionnel :

1. Supprimer le fichier :  
   `sudo rm /boot/acpi-override.cpio`

2. Retirer la ligne dans GRUB :  
   `GRUB_EARLY_INITRD_LINUX_CUSTOM=`

3. Mettre à jour :  
   `sudo update-grub`

---

### Depuis GRUB (si le système ne démarre plus)

1. Appuyer sur **e** au démarrage  
2. Supprimer la référence à `acpi-override.cpio`  
3. Démarrer temporairement  

---

## 📄 Licence

Ce projet est sous licence **GNU General Public License v2.0**.

Vous êtes libre de :
- utiliser
- modifier
- redistribuer

Selon les termes de la **GPL v2** publiés par la Free Software Foundation.

---

## 🤝 Contribution

Les contributions sont bienvenues :
- Tests sur d'autres kernels
- Améliorations du patch DSDT
- Rapports de bugs

---

## 📌 Notes

Ce correctif contourne une limitation du firmware BIOS.  
Une mise à jour officielle du BIOS serait la solution idéale si disponible.
