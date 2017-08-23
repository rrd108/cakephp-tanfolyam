<?php
namespace App\Model\Table;

use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * Quotes Model
 *
 * @property \App\Model\Table\AuthorsTable|\Cake\ORM\Association\BelongsTo $Authors
 * @property \App\Model\Table\TagsTable|\Cake\ORM\Association\BelongsToMany $Tags
 *
 * @method \App\Model\Entity\Quote get($primaryKey, $options = [])
 * @method \App\Model\Entity\Quote newEntity($data = null, array $options = [])
 * @method \App\Model\Entity\Quote[] newEntities(array $data, array $options = [])
 * @method \App\Model\Entity\Quote|bool save(\Cake\Datasource\EntityInterface $entity, $options = [])
 * @method \App\Model\Entity\Quote patchEntity(\Cake\Datasource\EntityInterface $entity, array $data, array $options = [])
 * @method \App\Model\Entity\Quote[] patchEntities($entities, array $data, array $options = [])
 * @method \App\Model\Entity\Quote findOrCreate($search, callable $callback = null, $options = [])
 *
 * @mixin \Cake\ORM\Behavior\TimestampBehavior
 */
class QuotesTable extends Table
{

    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config)
    {
        parent::initialize($config);

        $this->setTable('quotes');
        $this->setDisplayField('quote');
        $this->setPrimaryKey('id');

        $this->addBehavior('Timestamp');

        $this->belongsTo('Authors', [
            'foreignKey' => 'author_id',
            'joinType' => 'INNER'
        ]);
        $this->belongsTo('Users', [
            'foreignKey' => 'user_id',
            'joinType' => 'INNER'
        ]);
        $this->belongsToMany('Tags', [
            'foreignKey' => 'quote_id',
            'targetForeignKey' => 'tag_id',
            'joinTable' => 'quotes_tags'
        ]);
    }

    /**
     * Default validation rules.
     *
     * @param \Cake\Validation\Validator $validator Validator instance.
     * @return \Cake\Validation\Validator
     */
    public function validationDefault(Validator $validator)
    {
        $validator
            ->integer('id')
            ->allowEmpty('id', 'create');

        $validator
            ->requirePresence('quote', 'create')
            ->notEmpty('quote');

        return $validator;
    }

    /**
     * Returns a rules checker object that will be used for validating
     * application integrity.
     *
     * @param \Cake\ORM\RulesChecker $rules The rules object to be modified.
     * @return \Cake\ORM\RulesChecker
     */
    public function buildRules(RulesChecker $rules)
    {
        $rules->add($rules->existsIn(['author_id'], 'Authors'));

        return $rules;
    }

    public function findOwnedBy(Query $query, array $options)
    {
        return $query
            ->contain(['Users', 'Tags'])
            ->matching('Users', function ($q) use ($options) {
                return $q->where(['Users.username' => $options['userName']]);
            });
    }

    public function findTaggedBy(Query $query, array $options)
    {
        return $query
            ->contain(['Users', 'Tags'])
            ->matching('Tags', function ($q) use ($options) {
                return $q->where(['Tags.name' => $options['tagName']]);
            });
    }

    public function findOwnedAndTaggedBy(Query $query, array $options)
    {
        return $query
            ->contain(['Users', 'Tags'])
            ->matching('Users', function ($q) use ($options) {
                return $q->where(['Users.username' => $options['userName']]);
            })
            ->matching('Tags', function ($q) use ($options) {
                return $q->where(['Tags.name' => $options['tagName']]);
            });
    }

    public function findBetterOwnedAndTaggedBy(Query $query, array $options)
    {
        $queryTemp1 = $query->cleanCopy();
        $queryTemp2 = $query->cleanCopy();

        return $queryTemp1->find('taggedBy', $options)
            ->where(['Quotes.id IN' => $queryTemp2->find('ownedBy', $options)->select('id')]);   
    }
}
