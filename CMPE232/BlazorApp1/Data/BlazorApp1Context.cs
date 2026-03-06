using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using ClassLibrary1;

namespace BlazorApp1.Data
{
    public class BlazorApp1Context : DbContext
    {
        public BlazorApp1Context(DbContextOptions<BlazorApp1Context> options)
            : base(options)
        {
        }

        public DbSet<ClassLibrary1.Ability> Ability { get; set; } = default!;
        public DbSet<ClassLibrary1.Habitat> Habitat { get; set; } = default!;
        public DbSet<ClassLibrary1.Monster> Monster { get; set; } = default!;
        public DbSet<ClassLibrary1.Loot> Loot { get; set; } = default!;
        public DbSet<ClassLibrary1.Trait> Trait { get; set; } = default!;
        public DbSet<ClassLibrary1.Monster_Weaknesses> Monster_Weaknesses { get; set; } = default!;
        public DbSet<ClassLibrary1.Monster_Habitat_Loot> Monster_Habitat_Loot { get; set; } = default!;
        public DbSet<ClassLibrary1.Monster_Type> Monster_Type { get; set; } = default!;
        public DbSet<ClassLibrary1.Damage_Type> Damage_Type { get; set; } = default!;
        public DbSet<ClassLibrary1.Monster_Resistances> Monster_Resistances { get; set; } = default!;

        // 👇 İŞTE YENİ EKLENEN PARÇA BURASI 👇
        public virtual DbSet<ClassLibrary1.Monster_Abilities> Monster_Abilities { get; set; } = default!;
        public virtual DbSet<Monster_Traits> Monster_Traits { get; set; }
    }
}