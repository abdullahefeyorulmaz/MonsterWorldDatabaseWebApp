using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using monsterr;

namespace Monster.Data
{
    public class MonsterContext : DbContext
    {
        public MonsterContext (DbContextOptions<MonsterContext> options)
            : base(options)
        {
        }

        public DbSet<monsterr.Ability> Ability { get; set; } = default!;
    }
}
