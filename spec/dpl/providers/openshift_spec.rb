describe Dpl::Providers::Openshift do
  let(:args) { |e| %w(--server server --token token --project project) + args_from_description(e) }

  before { subject.run }

  describe 'by default', record: true do
    it { should have_run 'curl https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.1/linux/oc.tar.gz | tar xz' }
    it { should have_run './oc login --token=token --server=server' }
    it { should have_run 'git stash --all' }
    it { should have_run './oc project project' }
    it { should have_run './oc start-build dpl --follow --commit sha' }
    it { should have_run_in_order }
  end

  describe 'given --app other' do
    it { should have_run './oc start-build other --follow --commit sha' }
  end
end
