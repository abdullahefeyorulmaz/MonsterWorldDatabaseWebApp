namespace ClassLibrary1
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations; // Gerekli
    using System.ComponentModel.DataAnnotations.Schema; // <-- BU KÜTÜPHANE ŞART (ForeignKey için)

    public partial class Monster
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Monster()
        {
            this.Monster_Abilities = new HashSet<Monster_Abilities>();
            this.Monster_Habitat_Loot = new HashSet<Monster_Habitat_Loot>();
            this.Monster_Resistances = new HashSet<Monster_Resistances>();
            this.Monster_Traits = new HashSet<Monster_Traits>();
            this.Monster_Weaknesses = new HashSet<Monster_Weaknesses>();
        }

        public int ID { get; set; }

        [Required(ErrorMessage = "Canavar ismi zorunludur.")]
        [StringLength(50)]
        public string Name { get; set; }

        public decimal Challenge_Rating { get; set; }

        // Veritabanındaki gerçek sütun adı
        public int Monster_Type_ID { get; set; }

        // 👇 İŞTE DÜZELTME BURADA 👇
        // Sisteme diyoruz ki: "Bu ilişkinin anahtarı Monster_TypeID değil, Monster_Type_ID'dir!"
        [ForeignKey("Monster_Type_ID")]
        public virtual Monster_Type Monster_Type { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Monster_Abilities> Monster_Abilities { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Monster_Habitat_Loot> Monster_Habitat_Loot { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Monster_Resistances> Monster_Resistances { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Monster_Traits> Monster_Traits { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Monster_Weaknesses> Monster_Weaknesses { get; set; }
    }
}