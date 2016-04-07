# context 'calculating political bias #political_leaning_scores' do
#   subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}
#
#     describe '#political_leaning_perc' do
#
#       it 'returns a score between -100 and 100 for political leniency' do
#         expect(analysis.political_leaning_perc).to be_between(-100, 100).inclusive
#       end
#
#     end
#
#     describe '#political_leaning_scores' do
#
#     it 'returns an array of the scores out of 100 for political leniencies' do
#       expect(analysis.political_leaning_scores).to include(80, 100, -100)
#     end
#   end
# end
#
# # describe '#find_media_diet' do
# #   subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}
# #
# #   it 'can use the news source list to find out number of each article read' do
# #     expect(url_analysis.find_media_diet(url_analysis.sources_to_analyse)).to eq({dailymail: 33, telegraph: 33, theguardian: 33})
# #   end
# #
# #   it 'can also use the keyword list to find out how much of one topic read' do
# #     expect(url_analysis.find_media_diet(url_analysis.topics_to_analyse)).to include(:osborne => 50, :warn => 25, :storm => 25)
# #   end
# #
# #
# # end
#
# describe '#find_right_message' do
#   subject(:url_analysis) {described_class.new(url_parser_klass, papers_klass, url_parser_klass)}
#
#
#   it 'returns an appropriate messaged based on political_leaning_perc' do
#     expect(url_analysis.find_right_message).to eq("benefit-scrounger blamer")
#   end
#
# end
#
# end
