<?php
namespace App\Controller;

use App\Controller\AppController;
use Cake\Log\Log;

/**
 * Quotes Controller
 *
 * @property \App\Model\Table\QuotesTable $Quotes
 *
 * @method \App\Model\Entity\Quote[] paginate($object = null, array $settings = [])
 */
class QuotesController extends AppController
{

    /**
     * Index method
     *
     * @return \Cake\Http\Response|void
     */
    public function index()
    {
        /*$this->paginate = [
            'contain' => ['Authors', 'Tags']
        ];
        $quotes = $this->paginate($this->Quotes);*/

        $quotes = $this->Quotes->find()->contain(['Authors', 'Tags']);

        $this->set(compact('quotes'));
        $this->set('_serialize', ['quotes']);
    }

    /**
     * View method
     *
     * @param string|null $id Quote id.
     * @return \Cake\Http\Response|void
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function view($id = null)
    {
        $quote = $this->Quotes->get($id, [
            'contain' => ['Authors', 'Tags']
        ]);

        $this->set('quote', $quote);
        $this->set('_serialize', ['quote']);
    }

    /**
     * Add method
     *
     * @return \Cake\Http\Response|null Redirects on successful add, renders view otherwise.
     */
    public function add()
    {
        $quote = $this->Quotes->newEntity();
        if ($this->request->is('post')) {
            $request = $this->request->withData('user_id', $this->Auth->user('id'));
            $quote = $this->Quotes->patchEntity($quote, $request->getData());
            if ($this->Quotes->save($quote)) {
                $this->Flash->success(__('The quote has been saved.'));

                return $this->redirect(['action' => 'index']);
            }
            $this->Flash->error(__('The quote could not be saved. Please, try again.'));
        }
        $authors = $this->Quotes->Authors->find('list', ['limit' => 200]);
        $tags = $this->Quotes->Tags->find('list', ['limit' => 200]);
        $this->set(compact('quote', 'authors', 'tags'));
        $this->set('_serialize', ['quote']);
    }

    /**
     * Edit method
     *
     * @param string|null $id Quote id.
     * @return \Cake\Http\Response|null Redirects on successful edit, renders view otherwise.
     * @throws \Cake\Network\Exception\NotFoundException When record not found.
     */
    public function edit($id = null)
    {
        $quote = $this->Quotes->get($id, [
            'contain' => ['Tags']
        ]);
        if ($this->request->is(['patch', 'post', 'put'])) {
            $quote = $this->Quotes->patchEntity($quote, $this->request->getData());
            if ($this->Quotes->save($quote)) {
                $this->Flash->success(__('The quote has been saved.'));

                return $this->redirect(['action' => 'index']);
            }
            $this->Flash->error(__('The quote could not be saved. Please, try again.'));
        }
        $authors = $this->Quotes->Authors->find('list', ['limit' => 200]);
        $tags = $this->Quotes->Tags->find('list', ['limit' => 200]);
        $this->set(compact('quote', 'authors', 'tags'));
        $this->set('_serialize', ['quote']);
    }

    /**
     * Delete method
     *
     * @param string|null $id Quote id.
     * @return \Cake\Http\Response|null Redirects to index.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function delete($id = null)
    {
        $this->request->allowMethod(['post', 'delete']);
        $quote = $this->Quotes->get($id);
        if ($this->Quotes->delete($quote)) {
            $this->Flash->success(__('The quote has been deleted.'));
        } else {
            $this->Flash->error(__('The quote could not be deleted. Please, try again.'));
        }

        return $this->redirect(['action' => 'index']);
    }

    public function test()
    {
        debug($this->Quotes->find('ownedBy', ['userName' => 'Bendegúz'])->extract('id')->toArray());

        debug($this->Quotes->find('taggedBy', ['tagName' => 'pozitív'])->extract('id')->toArray());

        debug(
            $this->Quotes->find(
                'ownedAndTaggedBy',
                [
                    'userName' => 'Bendegúz',
                    'tagName' => 'pozitív'
                ]
                )
                ->extract('id')
                ->toArray()
        );

        debug(
            $this->Quotes->find(
                'betterOwnedAndTaggedBy',
                [
                    'userName' => 'Bendegúz',
                    'tagName' => 'pozitív'
                ]
                )
                ->extract('id')
                ->toArray()
        );
    }
}
