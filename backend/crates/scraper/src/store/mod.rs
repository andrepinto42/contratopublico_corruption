use anyhow::Context;
use common::{db::ContractDatabase, searchdb::SearchDatabase, Contract};
use log::info;

pub mod rangeset;

pub struct Store {
    search_database: SearchDatabase,
    contract_database: ContractDatabase,
}

impl Store {
    pub async fn contract_exists(&self, id: u64) -> bool {
        match self.contract_database.contract_exists(id).await {
            Ok(exists) => {
                if exists {
                    info!("Contract {id} already exists, skipping...");
                }
                return exists;
            }
            Err(e) => {
                info!("DB error: {e}");
                return true;
            }
        }
    }

    pub fn new(
        search_database: SearchDatabase,
        contract_database: ContractDatabase,
    ) -> anyhow::Result<Self> {
        Ok(Self {
            search_database,
            contract_database,
        })
    }

    pub async fn save_contract(&self, contract: Contract) -> anyhow::Result<()> {
        //Postgres update
        self.contract_database
            .insert_contract(&contract)
            .await
            .context("Failed to save contract in database")?;

        // Meilisearch update
        self.search_database.save_contract(contract).await?;

        Ok(())
    }
}
